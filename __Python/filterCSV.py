#!/usr/bin/env python
"""
filterCSV - Augments matching CSV files - according to iThoughts requirements

https://github.com/MartinPacker/filterCSV

It can set colours for nodes, change their shape, or delete them - if the node
matches any one of a set of criteria the user specifies.

Reads from stdin
Writes to stdout
Commentary to stderr


Command line parameters are pairs of:

1) A specifier. This is a regular expression to match. (A special value 'all' matches any value)
2) An action or sequence of actions. 

Actions can be:

* A colour number - relative to the top left of iThoughts' colour palette.
* A colour RGB value.
* 'delete'.
* A shape - as named by iThoughts.


"""

import os
import sys
import csv
import re
import string

# from CSVTree import CSVTree

filterCSV_level = "0.9"
filterCSV_date = "10 April, 2020"


class CSVTree(object):
    def __init__(self, shape, colour, note, level, position, cell):
        self.childNodes = []
        self.data = {
            "shape": shape,
            "colour": colour,
            "note": note,
            "level": level,
            "position": position,
            "cell": cell,
        }
        self.parent = None
        self.matched = False

    def addChild(self, childNode):
        self.childNodes.append(childNode)
        childNode.parent = self
        return childNode

    def deleteChild(self, childNode):
        self.childNodes.remove(childNode)

    def getChildren(self):
        return self.childNodes

    def isMatch(self, criterion):
        # Common method for establishing if a node matches some criterion, usually a regex
        if (
            (re.search(criterion, self.data["shape"]) != None)
            or (re.search(criterion, self.data["colour"]) != None)
            or (re.search(criterion, self.data["note"]) != None)
            or (re.search(criterion, self.data["cell"]) != None)
        ):
            return True
        else:
            return False

    def applyFilter(self, criterion, actionsList):
        # Apply filter to this node - if not tree root

        propagate = True
        if self.data["level"] != -1:
            cellColumn = int(self.data["level"]) + levelColumn + 1

            if self.isMatch(criterion):
                # Matched so apply all actions triggered by this match
                for action in actionsList:
                    if action == "delete":
                        # Delete the node
                        self.parent.deleteChild(self)

                        # Don't propagate
                        propagate = False
                    elif action[0] == "{":
                        # position specified
                        self.data["position"] = action

                        # Don't propagate
                        propagate = False
                    elif action == "note":
                        # Document the match in the note field
                        if self.data["note"] != "":
                            self.data["note"] += "\nMatched " + criterion.pattern
                        else:
                            self.data["note"] = "Matched " + criterion.pattern
                    elif action == "noshape":
                        # Remove any shape specification from the matched node
                        self.data["shape"] = ""
                    elif action == "nonote":
                        # Remove any note specification from the matched node
                        self.data["note"] = ""
                    elif action == "noposition":
                        # Remove any position specification from the matched node
                        self.data["position"] = ""
                    elif action == "nocolour":
                        # Remove any colour specification from the matched node
                        self.data["colour"] = ""
                    elif len(action) == 6:
                        if set(action).issubset(set(string.hexdigits)):
                            self.data["colour"] = action
                    else:
                        if action in shapes:
                            # Is a shape
                            self.data["shape"] = action
                        else:
                            if action.isdigit():
                                # Attempt to parse as from the colour palette
                                colourNumber = int(action)

                                # We have an integer. If it is too big but not 6 digits
                                # we flag an error and don't do the update
                                if colourNumber > colourCount:
                                    sys.stderr.write(
                                        "Erroneous colour value "
                                        + str(colourNumber)
                                        + " (Pattern was: '"
                                        + criterion.pattern
                                        + "').\n"
                                    )
                                else:
                                    self.data["colour"] = colours[colourNumber - 1]
                            else:
                                sys.stderr.write(
                                    "Erroneous action value "
                                    + str(action)
                                    + " (Pattern was: '"
                                    + criterion.pattern
                                    + "').\n"
                                )

        # Apply filter to children, recursively - if propagation is indicated
        if propagate is True:
            for child in self.childNodes:
                child.applyFilter(criterion, actionsList)

    def writeCSVTree(self, outputArray):
        # Compose this node's line - if not root node
        level = int(self.data["level"])
        if level > -1:
            line = []
            line.append(self.data["colour"])
            line.append(self.data["note"])
            line.append(self.data["position"])
            line.append(self.data["shape"])
            line.append(self.data["level"])
            for l in range(int(self.data["level"])):
                line.append("")
            line.append(self.data["cell"])
            outputArray.append(line)

        # Print children, recursively
        for child in self.childNodes:
            child.writeCSVTree(outputArray)

        return outputArray

    def checkHierarchy(self, actionsList):
        sys.stderr.write("Beginning Level Check\n")
        sys.stderr.write("---------------------\n")

        self._checkHierarchy(-2, actionsList)

        sys.stderr.write("---------------------\n")
        sys.stderr.write("Completed Level Check\n")

    def _checkHierarchy(self, previousLevel, actionsList):
        level = int(self.data["level"])
        if level > previousLevel + 1:
            sys.stderr.write(self.data["cell"].ljust(40) + " Error: ")
            sys.stderr.write("Expected level " + str(previousLevel + 1) + ".")
            sys.stderr.write(" Found level " + str(level) + ". ")

            firstAction = actionsList[0]

            if (firstAction == "repair") | (firstAction == "repairnode"):
                # Repair just this node
                self.data["level"] = previousLevel + 1
                sys.stderr.write(
                    "Repaired, setting level to " + str(previousLevel + 1) + ".\n"
                )
            elif firstAction == "repairsubtree":
                # Repair the whole subtree
                sys.stderr.write(
                    "Repaired this node (setting its level to "
                    + str(previousLevel + 1)
                    + ") and all its child nodes.\n"
                )
                self.repairSubtreeLevels(previousLevel)
            elif firstAction == "stop":
                # Terminate the check
                sys.stderr.write("Terminating.\n")
                sys.exit()
            else:
                sys.stderr.write("\n")
        else:
            if previousLevel > -2:
                sys.stderr.write(self.data["cell"].ljust(40) + " OK:   ")
                sys.stderr.write(" Found level " + str(level) + ".\n")
        for childNode in self.childNodes:
            childNode._checkHierarchy(previousLevel + 1, actionsList)

    def repairSubtreeLevels(self, parentLevel):
        # Repair this level
        self.data["level"] = parentLevel + 1

        # Repair lower levels
        for childNode in self.childNodes:
            childNode.repairSubtreeLevels(parentLevel + 1)

    def exportToMarkdown(self, actionsList):
        # Get the number of heading levels to allow before going to nested bulleted lists
        headingLevels = int(actionsList[0])

        if len(actionsList) > 1:
            # Get first heading level
            startingLevel = int(actionsList[1])
        else:
            # Default to starting at heading level 1
            startingLevel = 1

        self._exportToMarkdown(headingLevels - 1, startingLevel)

    def _exportToMarkdown(self, maxHeadingLevel, startingLevel):
        level = int(self.data["level"])
        if level > -1:
            note = self.data["note"]
            if level > maxHeadingLevel:
                print(
                    "  " * (level - maxHeadingLevel - startingLevel + 2)
                    + "* "
                    + self.data["cell"]
                )
                if note != "":
                    print("<br/><br/>" + note + "\n")
            else:
                print(
                    "\n"
                    + "#" * (level + startingLevel)
                    + " "
                    + self.data["cell"]
                    + "\n"
                )
                if note != "":
                    print(note + "\n")

        for childNode in self.childNodes:
            childNode._exportToMarkdown(maxHeadingLevel, startingLevel)

    def calculateMaximumLevel(self):
        return self._calculateMaximumLevel(0)

    def _calculateMaximumLevel(self, maximumLevel):
        level = int(self.data["level"])
        maximumLevel = max(level, maximumLevel)

        for childNode in self.childNodes:
            maximumLevel = max(
                maximumLevel, childNode._calculateMaximumLevel(maximumLevel)
            )

        return maximumLevel

    def exportToHTML(self, actionsList):
        action = actionsList[0]

        if action == "table":
            # Work out how many levels are needed
            maximumLevel = self.calculateMaximumLevel()

            # Write table start
            print("<table>")

            # Write table rows
            self._exportToHTMLTable(maximumLevel, action)

            # Write table end
            print("</table>")

        else:
            # Write top-level list start
            print("<ul style='list-style-type: none;'>")

            # Write nested list
            self._exportToHTMLList(action)

            # Write top-level list stop
            print("</ul>")

    def _exportToHTMLTable(self, maximumLevel, action):
        level = int(self.data["level"])

        # Determine the cell background colour
        colour = self.data["colour"]
        if colour == "":
            colour = "FFFFFF"

        # HTML table
        if level > -1:
            # Print table row start
            print("<tr>")

            # Print padding empty columns after the cell's column
            if level > 0:
                print("<td></td>" * level)

            # Print the cell itself, including styling
            print(
                "<td style='border: 1px solid black;border-radius: 5px;background-color: #"
                + colour
                + ";'>"
                + self.data["cell"]
                + "</td>"
            )

            # Print padding empty columns after the cell's column
            if level < maximumLevel:
                print("<td></td>" * (maximumLevel - level))

            # Print any note as a final column
            note = self.data["note"]
            if note != "":
                print("<td>" + note + "</td>")

            # Print table row end
            print("</tr>")

        for childNode in self.childNodes:
            childNode._exportToHTMLTable(maximumLevel, action)

    def _exportToHTMLList(self, action):
        level = int(self.data["level"])

        # Determine the cell background colour
        colour = self.data["colour"]
        if colour == "":
            colour = "FFFFFF"

        # Determine if there is a note
        note = self.data["note"]

        # HTML nested list
        if level > -1:
            indent = "  " * (level + 1)
            # print list item
            print(
                indent
                + "<li style='padding: 10px;'><span style='border: 1px solid black;padding: 5px;border-radius: 5px;background-color: #"
                + colour
                + ";'>"
                + self.data["cell"]
                + "</span>"
            )

            # Print any note
            if note != "":
                print(indent + "  <br/><br/>" + note)

            needListElements = len(self.childNodes) > 0
            if needListElements is True:
                print(indent + "<ul style='list-style-type: none;'>")

        returnedLevel = -2
        for childNode in self.childNodes:
            returnedLevel = childNode._exportToHTMLList(action)

        if level > -1:
            if needListElements is True:
                print(indent + "</ul>")

            print(indent + "</li>")

        return level

    def exportToXML(self, actionsList):
        action = actionsList[0]

        if action == "freemind":
            # Freemind XML export
            self.exportToFreemindXML(actionsList)
        elif action == "opml":
            self.exportToOPMLXML(actionList)

    def exportToFreemindXML(self, actionsList):
        # Export to XML in the format Freemind, MindNode and iThoughts accept

        # Warn if resulting XML would produce more than 1 Level 0 node
        if len(self.childNodes) > 1:
            sys.stderr.write(
                "Exported XML will have more than 1 root node. Some programs will get confused by this. Continuing.\n"
            )

        # Start the map
        print("<map>")

        # Recursively print the nodes
        self._exportToFreemindXML(actionsList)

        # Finish the map
        print("</map>")

    def _exportToFreemindXML(self, actionslist):
        level = int(self.data["level"])

        if level > -1:
            # Print this node
            colour = self.data["colour"]
            cell = self.data["cell"]

            note = self.data["note"]
            shape = self.data["shape"]

            indent = "  " * (level + 1)
            if colour == "":
                print(indent + "<node TEXT='" + cell + "'>")
            else:
                print(
                    indent
                    + "<node BACKGROUND_COLOR='#"
                    + colour
                    + "' TEXT='"
                    + cell
                    + "'>"
                )

            if note != "":
                print(indent + "  <richcontent TYPE='NOTE'><html>")
                print(indent + "    <head></head>")
                print(indent + "    <body>")
                print(indent + "      <p>")
                print(indent + "        " + note)
                print(indent + "      </p>")
                print(indent + "    </body>")

                print(indent + "  </richcontent>")

        for childNode in self.childNodes:
            childNode._exportToFreemindXML(actionList)

        if level > -1:
            print(indent + "</node>")

    def exportToOPMLXML(self, actionsList):
        # Export to OPML XML

        # Warn if resulting XML would produce more than 1 Level 0 node
        if len(self.childNodes) > 1:
            sys.stderr.write(
                "Exported XML will have more than 1 root node. Some programs will get confused by this. Continuing.\n"
            )

        # Start the map
        print("<?xml version='1.0'?>")
        print("<opml version='2.0'>")
        print("  <head>")
        print("  </head>")
        print("  <body>")

        # Recursively print the nodes
        self._exportToOPMLXML(actionsList)

        # Finish the map
        print("  </body>")
        print("</opml>")

    def _exportToOPMLXML(self, actionslist):
        level = int(self.data["level"])

        if level > -1:
            # Print this node
            colour = self.data["colour"]
            cell = self.data["cell"]

            note = self.data["note"]
            shape = self.data["shape"]

            indent = "  " * (level + 2)
            if colour == "":
                printLine = indent + "<outline text='" + cell + "'"
            else:
                printLine = (
                    indent
                    + "<outline BACKGROUND_COLOR='#"
                    + colour
                    + "' text='"
                    + cell
                    + "'"
                )

            if note != "":
                printLine = printLine + " Note='" + note + "'"

            print(printLine + ">")

        for childNode in self.childNodes:
            childNode._exportToOPMLXML(actionList)

        if level > -1:
            print(indent + "</outline>")

    def processKeep(self, matchCriterion):
        # Reset all nodes' matched flags
        self._markUnmatched()

        # Apply tests to each node and mark it and all its children and ancestors matched
        self._processKeep(matchCriterion)

        # Delete any unmatched nodes
        self._deleteUnmarked()

    def _markUnmatched(self):
        self.matched = False

        for childNode in self.childNodes:
            childNode._markUnmatched()

    def _markAncestorsMatched(self):
        if self.data["level"] > -1:
            self.matched = True
            self.parent._markAncestorsMatched()

    def _markSubtreeMatched(self):
        self.matched = True
        for childNode in self.childNodes:
            childNode._markSubtreeMatched()

    def _processKeep(self, matchCriterion):
        if self.isMatch(matchCriterion) == True:
            # mark self and all the ancestors matched
            self._markAncestorsMatched()

            # mark self and its subtree matched
            self._markSubtreeMatched()
        else:
            # Maybe children etc are matches
            for childNode in self.childNodes:
                childNode._processKeep(matchCriterion)

    def _deleteUnmarked(self):
        for childNode in self.childNodes:
            childNode._deleteUnmarked()
        if self.data["level"] > -1:
            if self.matched == False:
                self.parent.deleteChild(self)

    def promoteLevel(self, actionslist):
        # Promote everything at the specified level, deleting parents
        promotedLevel = int(actionslist[0])
        if promotedLevel < 1:
            sys.stderr.write("Cannot promote level " + str(promotedLevel) + "\n")
            sys.exit()

        # Get nodes to promote
        nodesToPromote = self.findNodesAtLevel(promotedLevel)

        # Get their parents, removing duplicates
        parentsToDelete = []
        for node in nodesToPromote:
            if (node.parent in parentsToDelete) != True:
                parentsToDelete.append(node.parent)

        # Promote each parent's children
        for parent in parentsToDelete:
            # Insert each child in turn
            parentsParent = parent.parent
            for childNode in parent.childNodes:
                parentsParent.addChild(childNode)

            # Delete the parent
            parentsParent.deleteChild(parent)

        # Repair all the levels in the tree
        self.repairSubtreeLevels(-2)

    def findNodesAtLevel(self, level):
        # returns a list of nodes at a particular level
        return self._findNodesAtLevel(level, [])

    def _findNodesAtLevel(self, level, nodes):
        # recursive helper routine to search the tree for nodes at a certain level
        if self.data["level"] == level:
            nodes.append(self)
        else:
            for childNode in self.childNodes:
                nodes = childNode._findNodesAtLevel(level, nodes)

        return nodes


def formatWhitespaceCharacters(whitespace):
    formattedIndentCharacters = ""
    for c in whitespace:
        if c == " ":
            formattedIndentCharacters += "<space>"
        else:
            formattedIndentCharacters += "<tab>"
    return formattedIndentCharacters


matchCriteria = []
actionsLists = []

# Shapes as understood by iThoughts
shapes = [
    "auto",
    "rectangle",
    "square",
    "rounded",
    "pill",
    "parallelogram",
    "diamond",
    "triangle",
    "oval",
    "circle",
    "underline",
    "none",
    "square bracket",
    "curved bracket",
]

shapeCount = len(shapes)

# Colours from iThoughts palette
colours = [
    "FFB2B2",
    "FFD8B2",
    "FFFFB2",
    "D8FFB2",
    "B2FFB2",  # 1 - 5
    "B2FFD8",
    "B2FFFF",
    "B2D8FF",
    "B2B2FF",
    "D8B2FF",  # 6 - 10
    "FFB2FF",
    "FFB2D8",
    "B24747",
    "B27C47",
    "B2B247",  # 11 - 15
    "7CB247",
    "47B247",
    "47B27C",
    "47B2B2",
    "477CB2",  # 16 - 20
    "4747B2",
    "7C47B2",
    "B247B2",
    "B2477C",
    "FF0000",  # 21 - 25
    "FF7F00",
    "FFFF00",
    "7FFF00",
    "00FF00",
    "00FF7F",  # 26 - 30
    "00FFFF",
    "007FFF",
    "0000FF",
    "7F00FF",
    "FF00FF",  # 31 - 35
    "FF007F",
    "000000",
    "929292",
    "a9a9a9",
    "C0C0C0",  # 36 - 40
    "D6D6D6",
    "FFFFFF",
    "002b36",
    "073642",
    "586e75",  # 41 - 45
    "657b83",
    "839496",
    "93a1a1",
    "eee8d5",
    "fdf6e3",  # 46 - 50
    "b58900",
    "cb4b16",
    "dc322f",
    "d33682",
    "6c71c4",  # 51 - 55
    "268bd2",
    "2aa198",
    "859900",  # 56 - 58
]

colourCount = len(colours)
nextColour = 0
nextShape = 0

# Heading for parameters display
sys.stderr.write("\nfilterCSV " + filterCSV_level + " (" + filterCSV_date + ")\n\n")
sys.stderr.write("Criterion".ljust(40, " ") + " Actions\n")
sys.stderr.write("---------".ljust(40, " ") + " -------\n")

# Read in pairs of parameters from command line
parmNumber = 1
for parmPair in range((len(sys.argv) - 1) // 2):
    # Handle match criterion
    matchCriterion = sys.argv[parmNumber]
    if matchCriterion == "all":
        matchCriteria.append(re.compile(".*"))
    else:
        matchCriteria.append(re.compile(matchCriterion))

    parmNumber += 1

    # Handle the actions that go with this match criterion
    actionsString = sys.argv[parmNumber].lower()
    actionList = actionsString.split()

    # For nextcolour/samecolour and nextshape/sameshape etc rewrite action as the colour number or shape
    for actionNumber in range(len(actionList)):
        action = actionList[actionNumber]
        if action in ("nextcolour", "nextcolor", "nc"):
            actionList[actionNumber] = str(nextColour)
            nextColour += 1
        elif action in ("samecolour", "samecolor", "sc"):
            actionList[actionNumber] = str(nextColour - 1)
            nextColour += 1
        elif action in ("nextshape", "ns"):
            actionList[actionNumber] = shapes[nextShape]
            nextShape += 1
        elif action == ("sameshape", "ss"):
            actionList[actionNumber] = shapes[nextShape - 1]
            nextShape += 1

    # Add actions list to list of actions lists
    actionsLists.append(actionList)

    parmNumber += 1

    sys.stderr.write(matchCriterion.ljust(40, " ") + " " + actionsString + "\n")

sys.stderr.write("\n\n")

# Build array of rows
csvRows = []
with sys.stdin as csvfile:
    reader = csv.reader(csvfile)

    for row in reader:
        csvRows.append(row)

# Find colour and level cells
colourColumn = -1
levelColumn = -1
noteColumn = -1
shapeColumn = -1
positionColumn = -1

cellNumber = 0
for cell in csvRows[0]:
    if cell == "colour":
        colourColumn = cellNumber
    elif cell == "level":
        levelColumn = cellNumber
    elif cell == "note":
        noteColumn = cellNumber
    elif cell == "shape":
        shapeColumn = cellNumber
    elif cell == "position":
        positionColumn = cellNumber
    cellNumber += 1

if levelColumn == -1:
    # This is a case where the input file is not valid for iThoughts

    # Work out what an indent would be - in numbers of characters per level
    indent = -1
    for row in csvRows:
        cell = row[0]
        indent = len(cell) - len(cell.lstrip())
        if indent > 0:
            # This is the first line with whitespace at the beginning
            sys.stderr.write("Indentation detected: ")

            # Save the indentation whitespace
            indentCharacters = cell[0:indent]

            # Print the detected indentation - so user can debug
            sys.stderr.write(formatWhitespaceCharacters(indentCharacters) + "\n")

            break
    # Insert a header row, with a level column and a level0 column
    csvRows.insert(
        0,
        [
            "level",
            "level0",
            "level1",
            "level2",
            "level3",
            "level4",
            "level5",
            "level6",
            "level7",
            "level8",
            "level9",
            "level10",
            "level11",
            "level12",
            "level13",
            "level14",
            "level15",
            "level16",
            "level17",
            "level18",
            "level19",
            "level20",
        ],
    )

    # Add a level column if one is not already present, and move the text into the right
    # level
    emptyCell = ""
    for rowNumber in range(len(csvRows)):
        if rowNumber > 0:
            # A data row so work out how many levels deep it is indented
            cell = csvRows[rowNumber][0]
            rowIndent = len(cell) - len(cell.lstrip())
            if rowIndent % indent > 0:
                sys.stderr.write("Bad indentation: ")
                if rowIndent == 1:
                    sys.stderr.write("1 white space character.")
                else:
                    sys.stderr.write(str(rowIndent) + " white space characters.")

                sys.stderr.write(
                    "Should be multiple of "
                    + str(indent)
                    + ". Rounding level down to "
                    + str(rowIndent / indent)
                    + ".\n"
                )
                sys.stderr.write(
                    "Line in error (" + str(rowNumber) + ") is: " + cell + "\n"
                )
                sys.stderr.write(
                    "Leading white space characters: "
                    + formatWhitespaceCharacters(cell[0:rowIndent])
                    + "\n"
                )
            else:
                rowIndentCharacters = cell[0:rowIndent]
                if rowIndentCharacters != indentCharacters * (rowIndent // indent):
                    sys.stderr.write("Bad indentation characters:\n")
                    sys.stderr.write(
                        "Line in error (" + str(rowNumber) + ") is: " + cell + "\n"
                    )
                    sys.stderr.write(
                        "Leading white space characters: "
                        + formatWhitespaceCharacters(rowIndentCharacters)
                        + "\n"
                    )

            level = rowIndent // indent
            csvRows[rowNumber].insert(0, str(level))

            # Replace text cell with cleaned version of itself
            cleanedCell = cell.lstrip()
            if cleanedCell[0:2] == "* ":
                cleanedCell = cleanedCell[2:]
            csvRows[rowNumber][1] = cleanedCell

            # Insert blank cells - according to level
            for l in range(level):
                csvRows[rowNumber].insert(1, "")

    levelColumn = 0

    #  Increment any other columns that exists' column numbers
    if colourColumn != -1:
        colourColumn += 1
    if noteColumn != -1:
        noteColumn += 1
    if shapeColumn != -1:
        shapeColumn += 1

if positionColumn == -1:
    # Add a position column if one is not already present
    for rowNumber in range(len(csvRows)):
        if rowNumber == 0:
            csvRows[rowNumber].insert(0, "position")
        else:
            csvRows[rowNumber].insert(0, "")
    positionColumn = 0

    #  Increment any other columns that exists' column numbers
    if levelColumn != -1:
        levelColumn += 1
    if colourColumn != -1:
        colourColumn += 1
    if noteColumn != -1:
        noteColumn += 1
    if shapeColumn != -1:
        shapeColumn += 1

if noteColumn == -1:
    # Add a note column if one is not already present
    for rowNumber in range(len(csvRows)):
        if rowNumber == 0:
            csvRows[rowNumber].insert(0, "note")
        else:
            csvRows[rowNumber].insert(0, "")
    noteColumn = 0

    #  Increment any other columns that exists' column numbers
    if levelColumn != -1:
        levelColumn += 1
    if colourColumn != -1:
        colourColumn += 1
    if positionColumn != -1:
        positionColumn += 1
    if shapeColumn != -1:
        shapeColumn += 1
else:
    if noteColumn == len(csvRows[0]) - 1:
        for rowNumber in range(1, len(csvRows)):
            if len(csvRows[rowNumber]) < noteColumn + 1:
                for r in range(len(csvRows[rowNumber]), noteColumn + 1):
                    csvRows[rowNumber].append("")

if colourColumn == -1:
    # Add a colour column if one is not already present
    for rowNumber in range(len(csvRows)):
        if rowNumber == 0:
            csvRows[rowNumber].insert(0, "colour")
        else:
            csvRows[rowNumber].insert(0, "")
    colourColumn = 0

    #  Increment any other columns that exists' column numbers
    if levelColumn != -1:
        levelColumn += 1
    if positionColumn != -1:
        positionColumn += 1
    if noteColumn != -1:
        noteColumn += 1
    if shapeColumn != -1:
        shapeColumn += 1

if shapeColumn == -1:
    # Add a shape column if one is not already present
    for rowNumber in range(len(csvRows)):
        if rowNumber == 0:
            csvRows[rowNumber].insert(0, "shape")
        else:
            csvRows[rowNumber].insert(0, "")
    shapeColumn = 0

    #  Increment any other columns that exists' column numbers
    if levelColumn != -1:
        levelColumn += 1
    if colourColumn != -1:
        colourColumn += 1
    if noteColumn != -1:
        noteColumn += 1
    if positionColumn != -1:
        positionColumn += 1

CSVwriter = csv.writer(sys.stdout, quoting=csv.QUOTE_ALL)

# Build the tree
currentLevel = -1
csvTree = CSVTree("", "", "", currentLevel, "", "")
currentNode = csvTree

for rowNumber in range(1, len(csvRows)):
    # Extract information from this row
    row = csvRows[rowNumber]
    level = int(row[levelColumn])
    shape = row[shapeColumn]
    colour = row[colourColumn]
    note = row[noteColumn]
    position = row[positionColumn]

    cellValue = row[levelColumn + level + 1]

    if level > currentLevel:
        # New child of previous node
        currentLevel = level
        currentNode = currentNode.addChild(
            CSVTree(shape, colour, note, level, position, cellValue)
        )
    elif level == currentLevel:
        # New sibling of previous node
        currentNode = currentNode.parent.addChild(
            CSVTree(shape, colour, note, level, position, cellValue)
        )
    else:
        # Not a sibling or child of previous node
        currentLevel = level

        # Look for the true parent by backing up the tree
        parentNode = currentNode
        while int(parentNode.data["level"]) >= int(level):
            parentNode = parentNode.parent

        # Add the new node - now we've found the parent to add it to
        currentNode = parentNode.addChild(
            CSVTree(shape, colour, note, level, position, cellValue)
        )

    currentNode.data["row"] = row

# Apply battery of parameter pairs to do the colouring etc
# (A row could match more than one and a later one overrides an earlier one)
# In some cases the "match criterion" is a command and the "actions list"
# contains parameters for that command. e.g. "markdown"
for parmPair in range(len(matchCriteria)):
    matchCriterion = matchCriteria[parmPair]
    actionsList = actionsLists[parmPair]
    if actionsList[0] == "keep":
        csvTree.processKeep(matchCriterion)
    elif matchCriterion.pattern.lower() == "check":
        csvTree.checkHierarchy(actionsList)
    elif matchCriterion.pattern.lower() == "markdown":
        csvTree.exportToMarkdown(actionsList)
        sys.exit()
    elif matchCriterion.pattern.lower() == "html":
        csvTree.exportToHTML(actionsList)
        sys.exit()
    elif matchCriterion.pattern.lower() == "xml":
        csvTree.exportToXML(actionsList)
        sys.exit()
    elif matchCriterion.pattern.lower() == "promote":
        csvTree.promoteLevel(actionsList)
    else:
        csvTree.applyFilter(matchCriterion, actionsList)

# Write the header row
CSVwriter.writerow(
    [
        "colour",
        "note",
        "position",
        "shape",
        "level",
        "level0",
        "level1",
        "level2",
        "level3",
        "level4",
        "level5",
        "level6",
        "level7",
        "level8",
        "level9",
        "level10",
        "level11",
        "level12",
        "level13",
        "level14",
        "level15",
        "level16",
        "level17",
        "level18",
        "level19",
        "level20",
    ]
)

# Write out the resulting CSV data
outputArray = []
outputArray = csvTree.writeCSVTree(outputArray)

for row in outputArray:
    CSVwriter.writerow(row)

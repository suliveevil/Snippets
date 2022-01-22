//#-hidden-code
//
//  main.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//
//#-end-hidden-code
/*:#localized(key: "FirstProseBlock")
 **Goal:** Modify the code to create your own set of rules for the cell simulator.

 To get started, run the code and observe what happens when you touch the live view to add living cells. The live view is initially filled with idle cells, but as the simulation runs these change to living or dead cells depending on the rules.
 
 Try modifying the rules of the simulation in the `configureCell(cell:)` function in the **SharedCode** file. Experiment with different values to see what happens.
 
 When you’re ready, move on to the next page to explore a more complex set of rules for the cell simulator.
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
//#-code-completion(module, show, MyFiles)
//#-code-completion(literal, show, color, integer, string)
//#-code-completion(keyword, show, if, func, var, let)
//#-code-completion(identifier, show, ., =, <=, >=, <, >, ==, !=, +, -, true, false, &&, ||, !, *, /, alive, dead, idle, pulsar, glider, pentadecathlon, capitalL, cellDimension, placePattern(_:atColumn:row:), cell, speed, state, numberOfAliveNeighbors, simulation, set(_:forState:), Pattern, configureCell(cell:), advancedConfigureCell(cell:), Simulation, configureCell)
//#-code-completion(identifier, hide, BlinkViewController, viewController, Coordinate, InitialStatePreset, Cell, storyBoard)

import UIKit
import PlaygroundSupport

let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
let viewController = storyBoard.instantiateInitialViewController() as! BlinkViewController

PlaygroundPage.current.liveView = viewController
//#-end-hidden-code
//#-editable-code
let simulation = Simulation()

//#-localizable-zone(ex2k1)
// simulation.cellDimension modifies the size of each cell. In order to see the cells, you must set this value to a number greater than 4. It is recommended that this value be no larger than 512.
//#-end-localizable-zone
simulation.cellDimension = 32

//#-localizable-zone(ex2k2)
// Try changing glider to pulsar.
//#-end-localizable-zone
simulation.placePattern(Pattern.glider, atColumn: 3, row: 3)

//#-localizable-zone(ex2k3)
// Try adjusting the speed to a number from 1 to 60.
//#-end-localizable-zone
simulation.speed = 2

//#-localizable-zone(ex2k4)
// Personalize your cells with your own images, text, or emojis.
//#-end-localizable-zone
simulation.set("😀", forState: .alive)
simulation.set(#colorLiteral(red: 0.4784313725, green: 0.7647058824, blue: 0.7568627451, alpha: 1), forState: .alive)
simulation.set("👻", forState: .dead)
simulation.set(#colorLiteral(red: 0.4784313725, green: 0.7647058824, blue: 0.7568627451, alpha: 1), forState: .dead)
simulation.set(#colorLiteral(red: 0.4784313725, green: 0.7647058824, blue: 0.7568627451, alpha: 1), forState: .idle)

simulation.configureCell = configureCell
//#-end-editable-code
//#-hidden-code

viewController.simulation = simulation
//#-end-hidden-code

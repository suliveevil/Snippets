# Snippets

## Why snippets are great.

If you need short fragments of text again and again you can now use Snippets in GoCoEdit. Snippets are like small templates optimized for fast use while typing. You can also insert snippets by typing ":s [snippetname]" in GoCoEdits CMD-MODE or use the external keyboard shortcut CMD+i. They appears within the Code Hint box. You can use it too for smart autocomplete features.
*requires GoCoEdit >= 10.0*

## How to create a Snippets.

You will found the snippet option under Settings -> Advanced -> Snippets

### Snippet Format - JSON (.gcesnippet)

Snippets are simple JSON or XML (choose the right file extension on saving, ".xml", ".sublime-snipped" or ".gcesnippet" are supported) files with a defined structure. Here is an JSON example:

```json
[
	{
		//how to trigger your snippet by typing | string
		"trigger" : "mysnippet",
		//content of your snippet | string or es6 template string
		"content" : "myfuntion(${1|param1},${2|param2});",
		//Optional language scope | array
		"modes" : ["javascript"]
	}
]
```

1 trigger | key combination to trigger the snippet [string]
2 content | the actual snippet [string or es6 template string]
3 modes | list of modes [array][optional]
4 description | name to display [string][optional]
 

## Fields

You can use field markers within the content of you snippet. You can cycle through positions within the snippet by pressing the Tab key.

function(${1},${2},${3})
 

## Place Holders

You can also insert a placeholder at your field markers.

function(${1|param1},${2|param2},${3|param3})
 

## Snippet Format - XML (.sublime-snippet or .xml)

XML Snippets are similar to snippets in Sublime Text. Fileds and Placeholders will work in the same way like sublime text. (xml snippets requires the sublime-snippet or xml file extension)

<snippet>
	<content><![CDATA[enter your snippet here.]]></content>
	<!-- trigger to activate the snippet -->
	<tabTrigger>mysnippet</tabTrigger>
	<!-- Optional - language scope -->
	<scope>source.javascript</scope>
	<!-- Optional - name to display -->
	<description>My Snippet</description>
</snippet>
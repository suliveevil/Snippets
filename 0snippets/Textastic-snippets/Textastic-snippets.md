# Snippets




description
uuid

set1
    name
    defaultAppend
    strings
        return
        strings
            break
            append:"${1:condition}:"

    name:
    defaultAppend:""
    strings:
        strings:
            string:"else if"
            append:"($1) {\n\t$0\n}"

set2
    description
    scope
    pattern
    completionCaptureIndex
    completionSetNames:[]
    <embed></embed>
{
	"description": "Textastic Code Completion for HTML Tags and Attributes",
	"uuid": "928A838C-F861-4902-92B8-58C29FCFC077",

	"completionSets": [
        {
			"name": "html.tags.with-newline",
			"defaultAppend": ">\n$0\n</$COMPLETION>",
			"strings": [
				"html",
				"body",
				"head"
			]
		},
		{
			"name": "html.tags.html5",
			"defaultAppend": ">$0</$COMPLETION>",
			"strings": [
				"article",
				"aside",
				{
					"string": "audio",
					"append": " src=\"$1\"${2: preload=\"${3:none}\"}${4: controls}>$0</audio>"
				},
				"bdi",
				"command",
				"datalist",
				"details",
				"embed",
				"figcaption",
				"figure",
				"footer",
				"header",
				"hgroup",
				"keygen",
				"mark",
				"meter",
				"nav",
				"output",
				"progress",
				"rp",
				"rt",
				"ruby",
				"samp",
				"section",
				{
					"string": "source",
					"append": " src=\"$1\" type=\"$2\" />$0"
				},
				"summary",
				"time",
				"track",
				{
					"string": "video",
					"append": " src=\"$1\"${2: preload=\"${3:none}\"}${4: controls}>$0</video>"
				}
			]
		},
	"contexts": [
		{
			"description": "HTML Tag Completion",
			"scope": "text.html - source - comment - string",
			"pattern": "<([a-zA-Z0-9]*)",
			"completionCaptureIndex": 1,
			"completionSetNames": [
				"html.tags.with-newline",
				"html.tags",
				"html.tags.self-closing",
				"html.tags.html5"
			]
		}
}
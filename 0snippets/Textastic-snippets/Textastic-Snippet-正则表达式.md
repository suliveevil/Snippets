# Textastic 正则表达式

## 基本原则

对象：已有文本、用户输入的文本、用户想要得到的目标文本

先匹配（match）已有文本+输入文本，如果匹配，则进行下一步，
再捕获（capture）输入文本，
将捕获的输入文本与string（代码片段的alias）进行对比，如果匹配，则进行下一步，
最后将输入文本替换为（replace）目标文本或在输入文本后面追加（append）目标文本


## \b boundary 边界符

## () capture group 捕获组

## (?…) nocapture group 非捕获组



```json
(?:^|\\s|\\})(@[a-zA-Z-+]*)
(?<!:)(?:^|\\s|;)([a-zA-Z\\-+]+)
(?<!<\\?)\\b([a-zA-Z_\\x7f-\\xff][a-zA-Z0-9_\\x7f-\\xff]*)
(?<!\\.)@([a-zA-Z]*)
(?<!\\.)\\b([a-zA-Z]+)
(?<!\\.)\\b([a-zA-Z]+)
(?<!\\.|@)\\b([a-zA-Z]+)
(?<!\\.|@)\\b([a-zA-Z]+)
(?<!\\.|\\[|\\(|,)\\b([a-zA-Z]+)
(?<!\\.|\\[|\\(|,)\\b(e[lse if]*)
(?<!\\.|\\[|\\(|,|@)\\b([a-zA-Z]+)
(?<!\\.|\\[|\\(|,|@)\\b(e[lse if]*)
(?<!new )\\b([A-Z][a-zA-Z]*)
(?<=`)[a-zA-Z0-9]*
(\\b[a-zA-Z0-9]+)
(blo[a-zA-Z0-9]*)
(cod[a-zA-Z]*)
(dot|ech|flo|gra|seq)[a-zA-Z]*
(im|pi|ur)[a-zA-Z0-9]*
(tco[a-zA-Z]*)
(tsf[a-zA-Z]*)
(tsn[a-zA-Z]*)
// this is done through Emmet
<([a-zA-Z0-9]*)
<([a-zA-Z0-9]*)
<([a-zA-Z0-9]*)(?:\\s+[a-zA-Z0-9-:_]+\\s*=\\s*(?:'.*'|\".*\"))*(?:(?:\\s([a-zA-Z0-9-]+))|\\s)
<([a-zA-Z0-9]*)(?:\\s+[a-zA-Z0-9-:_]+\\s*=\\s*(?:'.*'|\".*\"))*(?:(?:\\s([a-zA-Z0-9-]+))|\\s)
<([a-zA-Z0-9]*)(?:\\s+[a-zA-Z0-9-:_]+\\s*=\\s*(?:'.*'|\".*\"))*(?:\\s([a-zA-Z0-9-]+)\\s*=\\s*(?:[\"'])([a-zA-Z0-9-]*))
<([a-zA-Z0-9]*)(?:\\s+[a-zA-Z0-9-:_]+\\s*=\\s*(?:'.*'|\".*\"))*(?:\\s([a-zA-Z0-9-]+)\\s*=\\s*(?:[\"'])([a-zA-Z0-9-]*))
\\$([a-zA-Z_]*)
\\.([a-zA-Z][a-zA-Z ]*)
\\[\\[([a-zA-Z0-9:]*)
\\b(?:addEventListener|removeEventListener)\\s*\\(\\s*['\"]([a-zA-Z]*)
\\b([a-zA-Z0-9]+)
\\b(window|opener|parent|self|top)\\.(\\w*)
\\bDate\\.(\\w*)
\\bMath\\.(\\w*)
\\bNode\\.(\\w*)
\\bNumber\\.(\\w*)
\\bString\\.(\\w*)
\\bdocument\\.(\\w*)
\\bhistory\\.(\\w*)
\\blocalStorage\\.(\\w*)
\\blocation\\.(\\w*)
\\bnew\\s+([a-zA-Z]*)
\\bscreen\\.(\\w*
\\s*#([a-zA-Z]*)
\\s*#([a-zA-Z]*)
^\\|([a-zA-Z0-9]*)
```


```regex
(?:^|\s|\})(@[a-zA-Z-+]*)
(?<!:)(?:^|\s|;)([a-zA-Z\-+]+)
(?<!<\?)\b([a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)
(?<!\.)@([a-zA-Z]*)
(?<!\.)\b([a-zA-Z]+)
(?<!\.)\b([a-zA-Z]+)
(?<!\.|@)\b([a-zA-Z]+)
(?<!\.|@)\b([a-zA-Z]+)
(?<!\.|\[|\(|,)\b([a-zA-Z]+)
(?<!\.|\[|\(|,)\b(e[lse if]*)
(?<!\.|\[|\(|,|@)\b([a-zA-Z]+)
(?<!\.|\[|\(|,|@)\b(e[lse if]*)
(?<!new )\b([A-Z][a-zA-Z]*)
(?<=`)[a-zA-Z0-9]*
(\b[a-zA-Z0-9]+)
(blo[a-zA-Z0-9]*)
(cod[a-zA-Z]*)
(dot|ech|flo|gra|seq)[a-zA-Z]*
(im|pi|ur)[a-zA-Z0-9]*
(tco[a-zA-Z]*)
(tsf[a-zA-Z]*)
(tsn[a-zA-Z]*)
<([a-zA-Z0-9]*)
<([a-zA-Z0-9]*)
<([a-zA-Z0-9]*)(?:\s+[a-zA-Z0-9-:_]+\s*=\s*(?:'.*'|\".*\"))*(?:(?:\s([a-zA-Z0-9-]+))|\s)
<([a-zA-Z0-9]*)(?:\s+[a-zA-Z0-9-:_]+\s*=\s*(?:'.*'|\".*\"))*(?:(?:\s([a-zA-Z0-9-]+))|\s)
<([a-zA-Z0-9]*)(?:\s+[a-zA-Z0-9-:_]+\s*=\s*(?:'.*'|\".*\"))*(?:\s([a-zA-Z0-9-]+)\s*=\s*(?:[\"'])([a-zA-Z0-9-]*))
<([a-zA-Z0-9]*)(?:\s+[a-zA-Z0-9-:_]+\s*=\s*(?:'.*'|\".*\"))*(?:\s([a-zA-Z0-9-]+)\s*=\s*(?:[\"'])([a-zA-Z0-9-]*))
\$([a-zA-Z_]*)
\.([a-zA-Z][a-zA-Z ]*)
\[\[([a-zA-Z0-9:]*)
\b(?:addEventListener|removeEventListener)\s*\(\s*['\"]([a-zA-Z]*)
\b([a-zA-Z0-9]+)
\b(window|opener|parent|self|top)\.(\w*)
\bDate\.(\w*)
\bMath\.(\w*)
\bNode\.(\w*)
\bNumber\.(\w*)
\bString\.(\w*)
\bdocument\.(\w*)
\bhistory\.(\w*)
\blocalStorage\.(\w*)
\blocation\.(\w*)
\bnew\s+([a-zA-Z]*)
\bscreen\.(\w*
\s*#([a-zA-Z]*)
\s*#([a-zA-Z]*)
^\|([a-zA-Z0-9]*)
```



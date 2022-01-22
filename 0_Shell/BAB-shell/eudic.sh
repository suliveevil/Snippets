#!/bin/bash

eudic_version=$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" /Applications/Eudb_en.app/Contents/Info.plist)

# echo "$(pbpaste -Prefer text)"

# URL + 变量
if [ "$eudic_version" == "com.eusoft.eudic" ];then
    open -b 'com.eusoft.eudic'
osascript <<EOD
    tell application id "com.eusoft.eudic"
        activate
        show dic with word "query"
    end tell
EOD
elif [ "$eudic_version" == "com.eusoft.freeeudic" ];then
    open -b 'com.eusoft.freeeudic'
osascript <<EOD
    tell application id "com.eusoft.freeeudic"
        activate
        show dic with word "query"
    end tell
EOD
fi
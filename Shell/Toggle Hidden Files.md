# # Shift + Command + .



## shell script 实现

```shell
current_value=$(defaults read com.apple.finder AppleShowAllFiles)

if [ $current_value = "TRUE" ]

then

    defaults write com.apple.finder AppleShowAllFiles FALSE

else

    defaults write com.apple.finder AppleShowAllFiles TRUE

fi

    killall Finder
```


# bash

## 在 bash 中使用 vim 模式编辑

在 /etc/inputrc 中添加：

```bash
set editing-mode vi
set show-mode-in-prompt on
set vi-ins-mode-string \1\e[6 q\2
set vi-cmd-mode-string \1\e[2 q\2

# optionally:
# switch to block cursor before executing a command
set keymap vi-insert
RETURN: "\e\n"
```
# Vim

## 提权保存正在编辑的文件

```vim
:w !sudo tee %
```

## 退出 Vim

:wq 强制性写入文件并退出（存盘并退出 write and quite）。**即使文件没有被修改也强制写入，并更新文件的修改时间。**

:x 写入文件并退出。仅当文件被修改时才写入，并更新文件修改时间；否则不会更新文件修改时间。

## 参考


https://www.ibm.com/developerworks/cn/linux/l-tip-vim1/
https://www.ibm.com/developerworks/cn/linux/l-tip-vim2/
https://www.ibm.com/developerworks/cn/linux/l-tip-vim3/

https://vimjc.com

[Learn vim For the Last Time: A Tutorial and Primer](https://danielmiessler.com/study/vim/)
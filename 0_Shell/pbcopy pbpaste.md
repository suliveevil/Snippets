# pbcopy pbpaste

[TOC]

##  pbcopy

```bash
[liveevilsu@localhost ~]$ dict life | pbcopy


# System Clipboard
[1;31m################################### [0m
[1;31m# [0m life 生活
[1;31m# [0m (U: laɪf E: laɪf)
[1;31m# [0m
[1;31m# [0m n. 生活，生存；寿命
[1;31m# [0m
[1;31m# [0m Life : 生活
[1;31m# [0m         生命
[1;31m# [0m         LIFE (YUI单曲)
[1;31m# [0m Still Life : 静物
[1;31m# [0m               静物画
[1;31m# [0m               三峡好人
[1;31m# [0m Second Life : 第二人生
[1;31m# [0m                第二人生
[1;31m# [0m                第二生命
[1;31m################################### [0m


```

## which

```bash
[liveevilsu@localhost ~]$ whereis dict

[liveevilsu@localhost ~]$ which dict

/usr/local/bin/dict
```

## pbpaste

```bash
[liveevilsu@localhost ~]$ which dict | pbcopy
[liveevilsu@localhost ~]$ cd pbpaste

cd: no such file or directory: pbpaste

[liveevilsu@localhost ~]$ cd $pbpaste

[liveevilsu@localhost ~]$ ls

Applications               Music                      basic.png

Desktop                    Nutstore Files             ls.ps

Documents                  Pictures                   sample-graph.png

Downloads                  Public                     translate-shell

Library                    Virtual Machines.localized

Movies                     allmyfiles

[liveevilsu@localhost ~]$ cd $**(**pbpaste**)**

cd: not a directory: /usr/local/bin/dict
```
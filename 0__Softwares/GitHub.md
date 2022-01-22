# GitHub


```shell
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```


## SSH key

on Alpine Linux:

```shell
apk add openssh
```


```shell
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```


```shell
cd $HOME/.ssh
cat id_rsa.pub
```

复制粘贴到 GitHub

修改.git文件夹下config中的 URL 为 ssh 登陆格式 URL
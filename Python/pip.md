# pip

## 列出当前安装的包：

pip3 list

## 列出可升级的包：

```shell
pip3 list --outdate
```

## 升级一个包：

```shell
pip3 install --upgrade requests
# mac,linux,unix 在命令前加 sudo -H
```


## 升级所有可升级的包：

```shell
# 1
pip3 freeze --local | grep -v '^-e' | cut -d = -f 1  | xargs -n1 pip3 install -U

# 2
pip3 list -o --format legacy|awk '{print $1}'` ; do pip3 install --upgrade $i; done
```

## 导出依赖

```shell
pip freeze > requirements.txt

pip install -r requirements.txt
```
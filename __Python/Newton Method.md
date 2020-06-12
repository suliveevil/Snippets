# Newton Method

[TOC]



## 计算平方根

```python
# 导入模块numpy，并将numpy起个别名np（为了偷懒，下面少打几个字母）
import numpy as np

a = float(input(“please input a number:\n”))
print(np.sqrt(a))
```



## 牛顿法计算数字的平方根 方法一

```python
import math
from math import sqrt

def sqrt_binary(num):

# x是python自带math模块计算获得的值
x = sqrt(num)

y = num / 2.0
low = 0.0
up = num * 1.0
count = 1

while abs(y - x) > 0.00001: # 控制精度
    print(count, y)
    count += 1
    if (y * y > num):
        up = y
        y = low + (y - low) / 2
    else:
        low = y
        y = up - (up - y) / 2
return y


print(sqrt_binary(5))
print(sqrt(5))
```

## 牛顿法计算数字的平方根 方法二

```python
# 输入一个数字
n = float(input("please input a number:\n"))

# 定义一个函数，用来求平方根
def squareroot(n):

    # 第一次二分获得一个数字
    root = n/2
    
    # 继续二分
    for k in range(20): # 20用来控制二分次数，即精度
        root = (1/2) * (root + (n/root))
    
    # 二分法运行完毕，返回要求的root值
    return root

# 调用开平方函数，计算n的平方根
squareroot(n)
# 把结果输出到屏幕上
print(squareroot(n))
```







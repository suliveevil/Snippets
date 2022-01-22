# regex notes

## LeetCode

```javascript
#!/usr/bin/env python3\n# -*- coding: utf-8 -*-\n"""LeetCode-\n\n"""\n## input\n\n## Solution\n\n## output
```

## timer

### function


```javascript\nfrom functools import wraps\nimport time\n\n\ndef timer_func(function):\n	@wraps(function)\n	def function_timer(*args, **kwargs):\n		print('[Function: {name} start...]'.format(name=function.__name__))\n		t0 = time.time()\n		result = function(*args, **kwargs)\n		t1 = time.time()\n		print('[Function: {name} finished,\n Time Spend: {time:.9f}s]'.format(\n			name=function.__name__, time=t1 - t0))\n		return result\n\n	return function_timer\n\n\n@timer_func\ndef ${1:yourFunction}():\n    \n\nif __name__ == '__main__':\n	$COMPLETION(para)
```


### context
```javascript
from functools import wraps
import time

class MyTimer(object):
    '''
    用上下文管理器计时
    '''
    def __enter__(self):
        self.t0 = time.time()

    def __exit__(self, exc_type, exc_val, exc_tb):
        print('[finished, spent time: {time:.2f}s]'.format(time = time.time() - self.t0))

def test(x,y):
    s = x + y
    time.sleep(1.5)
    print('the sum is: {0}'.format(s))

if __name__ == '__main__':
    with MyTimer() as t:
        test(1,2)
        time.sleep(1)
        print('do other things')
```


import time
 

class Solution:
    """
    如果是负数，则转成正数处理。
    对于正数，末位数不断进位即可。
    最后判断溢出的情况
    """
    def reverse(self, x: int) -> int:
        negative = False
        if x < 0:
            negative = True
            x = x * (-1)
        cur = 0
        while(x != 0):
            cur = cur * 10 + x % 10
            x = x // 10
        cur = cur if not negative else cur * (-1)
        if -2**31< cur <2**31-1:
            return cur
        return 0


# Test

print("------计算开始-----") 
start_time = time.time()


s = Solution()
output = s.reverse(2836)
print(output)


end_time = time.time()
print("------计算结束-----")
print("计算耗时"+str(float(end_time-start_time)))



import time


class Solution:
    def lengthOfLastWord(self, s: str) -> int:
            a = s.split()
            if len(a) == 0:
                return 0
            else:
                l = len(a)
                return len(a[l-1])

# test
print("------计算开始-----") 
start_time = time.time()


s = Solution()
print(s.lengthOfLastWord("hello world"))


end_time = time.time()
print("------计算结束-----")
print("计算耗时"+str(float(end_time-start_time))) 

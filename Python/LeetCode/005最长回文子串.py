import time


class Solution:
    def longestPalindrome(self, s):
        """
        :type s: str
        :rtype: str
        """
        s = s
        mlen = len(s)
        while True:
            i = 0
            while i + mlen <= len(s):
                sl = s[i:i + mlen]
                sr = sl[::-1]
                if sl == sr:
                    return sl
                i = i + 1
            mlen = mlen - 1
            if mlen == 0:
                return "No solution"


# test

print("------计算开始-----") 
start_time = time.time()


test_str = "abchdggdhfhfgbd"
s = Solution()
print(s.longestPalindrome(test_str))


end_time = time.time()
print("------计算结束-----")
print("计算耗时"+str(float(end_time-start_time))) 


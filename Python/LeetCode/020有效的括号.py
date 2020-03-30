
import time


class Solution:

    def isValid(self, s):
        """
        :type s: str
        :rtype: bool
        """

        # s with odd length is not valid
        l = len(s)
        if l % 2 != 0:
            return False

        p = {"(": 1.1, ")": -1.1, "{": 2.22, "}": -2.22, "[": 3.333, "]": -3.333}
        num = [0]

        for c in s:
            if num[-1] + p[c] == 0:
                num.pop()
            else:
                num.append(p[c])
    
        if len(num) != 1:
            return False
        else:
            return True


        # while '[]' in s or '()' in s or '{}' in s:
        #     s = s.replace('[]', '').replace('()', '').replace('{}', '')

        # return not len(s)



# test

print("------计算开始-----") 
start_time = time.time()


s = Solution()
# print(s.isValid("()([)]"))
print(s.isValid("()[]"))


end_time = time.time()
print("------计算结束-----")
print("计算耗时"+str(float(end_time-start_time))) 


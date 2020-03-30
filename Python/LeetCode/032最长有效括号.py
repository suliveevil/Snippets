
import time


class Solution:
    def longestValidParentheses(self, s):
        """
        :type s: str
        :rtype: int
        """

        if len(s) == 0 or len(s) == 1:
            return 0

        stack = []
        j = 0
        max_len = 0

        while j < len(s):
            if s[j] == "(":
                stack.append(j)

            if s[j] == ")":
                if len(stack) and s[stack[-1]] == "(":
                    stack.pop()
                    if len(stack):
                        lens = j - stack[-1]
                        if lens > max_len:
                            max_len = lens
                    else:
                        lens = j + 1
                        if lens > max_len:
                            max_len = lens

                else:
                    stack.append(j)
            j += 1

        return max_len




# test

print("------计算开始-----") 
start_time = time.time()


s = Solution()
print(s.longestValidParentheses("[)()()()()]"))


end_time = time.time()
print("------计算结束-----")
print("计算耗时"+str(float(end_time-start_time))) 


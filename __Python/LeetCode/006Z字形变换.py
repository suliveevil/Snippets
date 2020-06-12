import time


class Solution:
    def convert(self, s: str, numRows: int) -> str:
        if numRows < 2: return s
        res = ["" for _ in range(numRows)]
        i, flag = 0, -1
        for c in s:
            res[i] += c
            if i == 0 or i == numRows - 1: flag = -flag
            i += flag
        return "".join(res)

# test
print("------计算开始-----") 
start_time = time.time()


s = Solution()
print(s.convert('HGABCGDJDDBVSGS', 3))


end_time = time.time()
print("------计算结束-----")
print("计算耗时"+str(float(end_time-start_time))) 

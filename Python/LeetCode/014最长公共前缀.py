
import time


class Solution:
    def longestCommonPrefix(self, strs):
        """
        :type strs: List[str]
        :rtype: str
        """

        if not strs:
            return ""

        # 找到最短的字符串
        shorest = min(strs, key=len)

        for i_th, letter in enumerate(shorest):

            for other in strs:

                if other[i_th] != letter:

                    return shorest[:i_th]

        return shorest



# test

print("------计算开始-----") 
start_time = time.time()


s = Solution()
print("here is longest prefix:",
      s.longestCommonPrefix(['flow', 'flower', 'flight']))


end_time = time.time()
print("------计算结束-----")
print("计算耗时"+str(float(end_time-start_time))) 


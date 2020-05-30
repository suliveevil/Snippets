
import time


class Solution:
    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        i = 0
        while i < len(nums):
            if i == len(nums) - 1:
                return "No solution here!"
            r = target - nums[i]
            # Can't use a num twice
            num_follow = nums[i + 1:]
            if r in num_follow:
                return [i, num_follow.index(r) + i + 1]
            i = i + 1

# 开始时间


start_time = time.time()

# Test

s = Solution()
output = s.twoSum([3, 4, 7, 5], 9)
print(output)

# 结束时间

end_time = time.time()

# 结束时间-开始时间

print("耗时"+str(float(end_time - start_time)))


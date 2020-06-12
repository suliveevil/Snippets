#!/usr/bin/env python
# coding=utf-8


import time


class Solution:
    def threeSumClosest(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: int
        """
        # 如果只有3个数，那直接返回这三个数的和
        if len(nums) == 3:
            return sum(nums)
        nums = sorted(nums)
        # 如果最小的和大于目标，那返回最小的和
        if sum(nums[:3]) >= target:
            return sum(nums[:3])
        # 如果最大的和小于目标，那返回最大的和
        if sum(nums[-3:]) <= target:
            return sum(nums[-3:])

        cur = nums[0] + nums[1] + nums[-1]

        for i in range(0, len(nums) - 2):
            # 避免重复计算
            if i > 0 and nums[i] == nums[i - 1]:
                continue
            j = i + 1
            k = len(nums) - 1

            while j < k:
                res = nums[i] + nums[j] + nums[k]
                if abs(res - target) < abs(cur - target):
                    cur = res
                elif res == target:
                    return target
                elif res < target:
                    j = j + 1
                else:
                    k = k - 1
        return cur




# test

print("------计算开始-----") 
start_time = time.time()

sum_of_3_num = [37,47,27]
sum_2 = 8


s = Solution()
output = s.threeSumClosest(sum_of_3_num,sum_2)
print(output)


end_time = time.time()
print("------计算结束-----")
print("计算耗时"+str(float(end_time-start_time))) 


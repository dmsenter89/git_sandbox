#!/usr/bin/env python

from typing import List

def print_sqrs(nums: List[float]):
    """Takes a list of floats and prints the square of each element."""
    print('--------------------')
    for elem in nums:
        print(f"{elem}^2 == {elem**2}")
    print('--------------------')

def some_function():
    pass

def main():
    some_nums = [4,8,12,4]
    print_sqrs(some_nums)

if __name__=='__main__':
    main()
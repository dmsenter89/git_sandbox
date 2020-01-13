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

def rachel_func():
    print("Rachel's function is going to win!!")

def main():
    some_nums = [11,324,34,74]
    print_sqrs(some_nums)
    rachel_func()

if __name__=='__main__':
    main()



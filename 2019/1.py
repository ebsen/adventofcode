#!/usr/bin/env python3

"""
https://adventofcode.com/2019/day/1

Fuel required to launch a given module is based on its mass. Specifically, to find the fuel required for a module, take its mass, divide by three, round down, and subtract 2.

For example:

- For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2.
- For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2.
- For a mass of 1969, the fuel required is 654.
- For a mass of 100756, the fuel required is 33583.

The Fuel Counter-Upper needs to know the total fuel requirement. To find it, individually calculate the fuel needed for the mass of each module (your puzzle input), then add together all the fuel values.

What is the sum of the fuel requirements for all of the modules on your spacecraft?
"""
import math


def required_fuel(mass: int):
    return math.floor(mass / 3) - 2


total = 0
with open("1.txt") as file:
    for line in file:
        total += required_fuel(int(line.strip()))

print("Result:")
print(total)
print("-------")

# Tests
print(f"2     == {required_fuel(12)}")
print(f"2     == {required_fuel(14)}")
print(f"654   == {required_fuel(1969)}")
print(f"33583 == {required_fuel(100756)}")

#!/usr/bin/env python3
from typing import List


def run(intcode: List[int]):
    pointer = 0
    opcode = intcode[pointer]
    while opcode != 99:
        input1 = intcode[intcode[pointer + 1]]
        input2 = intcode[intcode[pointer + 2]]
        if opcode == 1:
            """Add"""
            result = input1 + input2
        elif opcode == 2:
            """Multiply"""
            result = input1 * input2
        else:
            raise Exception(f"Invalid opcode: {opcode}")
        location = intcode[pointer + 3]
        intcode[location] = result
        pointer = pointer + 4
        opcode = intcode[pointer]
    return intcode


with open("2.txt") as program:
    intcode = [int(opcode) for opcode in program.readline().split(",")]
    intcode[1] = 12
    intcode[2] = 2
    result = run(intcode)
    print(result[0])


# # Tests
# intcodes = [
#     [1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50],
#     [1, 0, 0, 0, 99],
#     [2, 3, 0, 3, 99],
#     [2, 4, 4, 5, 99, 0],
#     [1, 1, 1, 4, 99, 5, 6, 0, 99],
# ]
# becomes = [
#     [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50],
#     [2, 0, 0, 0, 99],
#     [2, 3, 0, 6, 99],
#     [2, 4, 4, 5, 99, 9801],
#     [30, 1, 1, 4, 2, 5, 6, 0, 99],
# ]

# for i, c in enumerate(intcodes):
#     # print(i, type(c))
#     ending = run(c)
#     print(ending)
#     print(f'{becomes[i]} (Expected)')
#     print()
#     # print(ending)

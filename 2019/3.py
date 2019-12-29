#!/usr/bin/env python3

# wires = [
#     ["R75", "D30", "R83", "U83", "L12", "D49", "R71", "U7", "L72"],
#     ["U62", "R66", "U55", "R34", "D71", "R55", "D58", "R83"],
# ] # distance 159
# wires = [
#     ['R98', 'U47', 'R26', 'D63', 'R33', 'U87', 'L62', 'D20', 'R33', 'U53', 'R51'],
#     ['U98', 'R91', 'D20', 'R16', 'D67', 'R40', 'U7', 'R15', 'U6', 'R7'],
# ] # distance 135

wires = []
with open("3.txt") as input:
    for line in input.readlines():
        wires.append(line.strip().split(","))


def map_coords(wire):
    p = (0, 0)
    coords = []
    for place in wire:
        direction = place[0]
        d = int(place[1:])
        x, y = p
        if direction is "U":
            coords.extend([(x, y2) for y2 in range(y, y + d + 1)])
        elif direction is "R":
            coords.extend([(x2, y) for x2 in range(x, x + d + 1)])
        elif direction is "D":
            coords.extend([(x, y2) for y2 in range(y, y - d - 1, -1)])
        elif direction is "L":
            coords.extend([(x2, y) for x2 in range(x, x - d - 1, -1)])
        p = coords[-1]
    return coords


def shortest_intersection(wires):
    shortest = 0
    intersections = set(map_coords(wires[0])) & set(map_coords(wires[1]))
    for coord in intersections:
        if coord != (0, 0):
            x, y = coord
            if x < 0:
                x = x * -1
            if y < 0:
                y = y * -1
            distance = x + y
            if shortest == 0 or distance < shortest:
                shortest = distance
                print(shortest)
    return shortest


result = shortest_intersection(wires)
print(f"Answer: {result}")

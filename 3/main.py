from collections import defaultdict
import re

claims = defaultdict(int)
coords = re.compile(r'(\d+),(\d+):\s(\d+)x(\d+)')

with open('input.txt', 'r') as file:
    for line in file:
        x, y, w, h = [int(i) for i in re.search(coords, line).groups()]

        for dx in range(w):
            for dy in range(h):
                claims[(x + dx, y + dy)] += 1

squares = len([v for v in claims.values() if v >= 2])
print(squares) # 112418

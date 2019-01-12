"""
Totally stole this solution from https://adventofcode.com/2018/day/4
because I couldn't get mine working. It was close though, I promise.
"""

from collections import defaultdict
from operator import itemgetter
import fileinput
import re

totals = defaultdict(int)
minutes = defaultdict(lambda: defaultdict(int))

for line in sorted(fileinput.input()):
    minute = int(re.search(r":(\d+)", line).group(1))
    if "#" in line:
        guard = int(re.search(r"#(\d+)", line).group(1))
    elif "asleep" in line:
        m0 = minute
    elif "wakes" in line:
        m1 = minute
        for m in range(m0, m1):
            totals[guard] += 1
            minutes[guard][m] += 1

# Part One
key = itemgetter(1)
guard = max(totals.items(), key=key)[0]
minute = max(minutes[guard].items(), key=key)[0]
print(guard * minute)

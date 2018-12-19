import re

lines: list = []
with open("input.txt", "r") as file:
    # lines = sorted(file.readlines().strip())
    lines = sorted(file.readlines())
# print(lines)

# lines.strip().sort()
# print(lines)
for line in lines:
    if 'Guard' in line:

    re.search(r'\d{4}-(\d{2}-\d{2})', line)
    # if "1518" not in line:
    #     print(line)

example = {
    1033: {"10-04": ["05", "06", "07"], "10-07": ["34", "35", "36", "45", "46", "47"]}
}

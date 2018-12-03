frequency = 0

with open("input.txt", "r") as file:
    for line in file:
        change = int(line[1:])

        if line.startswith("+"):
            frequency += change
        if line.startswith("-"):
            frequency -= change

print(frequency)

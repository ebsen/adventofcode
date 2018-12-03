twos = 0
threes = 0

with open('input.txt', 'r') as file:
    for line in file:
        letters = {}

        for letter in line.strip():
            if letter in letters:
                letters[letter] += 1
            else:
                letters[letter] = 1

        # print(letters)
        if 2 in letters.values():
            twos += 1
        if 3 in letters.values():
            threes += 1

        # print(letters)
        # for k, v in letters.items():
        #     # print(k, v) if v is 2
        #     if v is 2:
        #         print(k, v)
        #         twos += 1
        #     if v is 3:
        #         threes += 1

# print(twos, threes)
print(twos * threes)


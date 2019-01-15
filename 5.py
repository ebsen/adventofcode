"""
The polymer is formed by smaller units which, when triggered, react with each other such that two adjacent units of the same type and opposite polarity are destroyed. Units' types are represented by letters; units' polarity is represented by capitalization. For instance, r and R are units with the same type but opposite polarity, whereas r and s are entirely different types and do not react.
"""


def react(polymer):
    units = [""]

    for unit in polymer:
        # Check if the unit reacts with the previous one.
        # Otherwise, add it to the list for the next comparison.
        if unit == units[-1].swapcase():
            units.pop()
        else:
            units.append(unit)

    return "".join(units)


print(len(react(open("5.txt", "r").read().strip())))

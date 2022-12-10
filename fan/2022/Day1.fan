
class Day1_2022 {
	
	private Str[]? input
	private Int[]  elves := Int[,]
	
	Void main() {
		start := DateTime.now(1ns)
		input = `inputs/2022/day1.txt`.toFile.readAllLines
		echo("Welcome to day 1!")
		echo("-----------------")
		echo("Part 1 answer: $part1")
		echo("Part 2 answer: $part2")
		echo("Computation time: ${(DateTime.now(1ns) - start)}")
	}
	
	private Obj? part1() {
		curVal := 0
		for (i := 0; i < input.size; i++) {
			if (input[i].trimToNull == null) {
				elves.add(curVal)
				curVal = 0
			} else {
				val := Int(input[i])
				curVal += val
			}
		}
		
		maxCals := elves.dup.sort.last
		elfIdx  := elves.findIndex { it == maxCals }
		return "Elf: ${elfIdx + 1}, Calories: ${maxCals}"
	}
	
	private Obj? part2() {
		sortedCals 	:= elves.dup.sort
		first		:= sortedCals.last
		second		:= sortedCals[-2]
		third		:= sortedCals[-3]
		
		firstElf	:= elves.findIndex { it == first  } + 1
		secondElf	:= elves.findIndex { it == second } + 1
		thirdElf	:= elves.findIndex { it == third  } + 1
		
		return "Elves: ${firstElf} ($first), ${secondElf} ($second), ${thirdElf} ($third), Calories: ${first + second + third}"
	}
	
}


class Day5 {
	
	private Str[]? input
	
	Void main() {
		start := DateTime.now(1ns)
		input = `inputs/2022/day5.txt`.toFile.readAllLines
		echo("Welcome to day 5!")
		echo("-----------------")
		echo("Part 1 answer: $part1")
		echo("Part 2 answer: $part2")
		echo("Computation time: ${(DateTime.now(1ns) - start)}")
	}
	
	private Obj? part1() {
		stacks := parseStacks(input[0..10])
		input.each |action, idx| { 
			if (!action.contains("move"))
				return
			
			split  			:= action.split
			amount 			:= Int(split[1])
			stackNumStart 	:= Int(split[3])
			stackNumEnd 	:= Int(split[5])
			
			stack := stacks[stackNumStart - 1]
			range := (-1 - (amount - 1)..-1)
			letters :=(Str[]) stack[range]
			flippedLetters := Str[,]
			letters.size.times {
				flippedLetters.add(letters[-1-it])
			}
			stack.removeRange(range)
			stacks[stackNumEnd - 1].addAll(flippedLetters)
		}
		
		return stacks.map { it.last }.join
	}
	
	private Obj? part2() {
		stacks := parseStacks(input[0..10])
		input.each |action, idx| { 
			if (!action.contains("move"))
				return
			
			split  			:= action.split
			amount 			:= Int(split[1])
			stackNumStart 	:= Int(split[3])
			stackNumEnd 	:= Int(split[5])
			
			stack := stacks[stackNumStart - 1]
			range := (-1 - (amount - 1)..-1)
			letters :=(Str[]) stack[range]
			stack.removeRange(range)
			stacks[stackNumEnd - 1].addAll(letters)
		}
		
		return stacks.map { it.last }.join
	}
	
	private Str[][] parseStacks(Str[] input) {
		stackLines := input.findAll { it.contains("[") }
		stacks := [Str[,],Str[,],Str[,],Str[,],Str[,],Str[,],Str[,],Str[,],Str[,]]
		for (i := stackLines.size - 1; i >= 0; i--) {
			[
				stackLines[i][1],
				stackLines[i][5],
				stackLines[i][9],
				stackLines[i][13],
				stackLines[i][17],
				stackLines[i][21],
				stackLines[i][25],
				stackLines[i][29],
				stackLines[i][33]
			].each |letter, idx| { 
				if (letter.toChar.trimToNull != null)
					stacks[idx].add(letter.toChar)
			}
		}
		return stacks
	}
	
}

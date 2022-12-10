
class Day2 {
	
	private Str[]? input
	
	Void main() {
		start := DateTime.now(1ns)
		input = `inputs/2022/day2.txt`.toFile.readAllLines
		echo("Welcome to day 2!")
		echo("-----------------")
		echo("Part 1 answer: $part1")
		echo("Part 2 answer: $part2")
		echo("Computation time: ${(DateTime.now(1ns) - start)}")
	}
	
	private Obj? part1() {
		totalScore 	:= 0
		input.each |moveStr| {
			oppMove := moveStr[0].toChar
			youMove := moveStr[2].toChar
			
			switch (youMove) {
				case "X": 
					totalScore += 1
					if (oppMove == "A") totalScore += 3
					if (oppMove == "C") totalScore += 6
				case "Y": 
					totalScore += 2
					if (oppMove == "B") totalScore += 3
					if (oppMove == "A") totalScore += 6
				case "Z": 
					totalScore += 3
					if (oppMove == "C") totalScore += 3
					if (oppMove == "B") totalScore += 6
			}
		}
		return totalScore
	}
	
	private Obj? part2() {
		totalScore 	:= 0
		input.each |moveStr| {
			oppMove := moveStr[0].toChar
			result  := moveStr[2].toChar
			
			switch (oppMove) {
				case "A": 
					if (result == "X") totalScore += 3
					if (result == "Y") totalScore += 4
					if (result == "Z") totalScore += 8
				case "B": 
					if (result == "X") totalScore += 1
					if (result == "Y") totalScore += 5
					if (result == "Z") totalScore += 9
				case "C": 
					if (result == "X") totalScore += 2
					if (result == "Y") totalScore += 6
					if (result == "Z") totalScore += 7
			}
		}
		return totalScore
	}
	
}


class Day4 {
	
	private Str[]? input
	
	Void main() {
		start := DateTime.now(1ns)
		input = `inputs/2022/day4.txt`.toFile.readAllLines
		echo("Welcome to day 4!")
		echo("-----------------")
		echo("Part 1 answer: $part1")
		echo("Part 2 answer: $part2")
		echo("Computation time: ${(DateTime.now(1ns) - start)}")
	}
	
	private Obj? part1() {
		numOverlaps :=  0
		input.each |inputStr| {
			firstRange := parseRange(inputStr.split(',').first)
			secondRange := parseRange(inputStr.split(',').last)
			if ((firstRange.contains(secondRange.first) && firstRange.contains(secondRange.last)) ||
				(secondRange.contains(firstRange.first) && secondRange.contains(firstRange.last)))
				numOverlaps++
		}
		return numOverlaps
	}
	
	private Obj? part2() {
		numOverlaps :=  0
		input.each |inputStr| {
			firstRange := parseRange(inputStr.split(',').first)
			secondRange := parseRange(inputStr.split(',').last)
			if ((firstRange.contains(secondRange.first) || firstRange.contains(secondRange.last)) ||
				(secondRange.contains(firstRange.first) || secondRange.contains(firstRange.last)))
				numOverlaps++
		}
		return numOverlaps
	}
	
	private Range parseRange(Str str) {
		firstVal := Int(str.split('-').first)
		secondVal := Int(str.split('-').last)
		return firstVal..secondVal
	}
	
}

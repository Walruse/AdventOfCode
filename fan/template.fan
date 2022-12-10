
class template {
	
	private Str[]? input
	
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
		throw UnsupportedErr("write this!")
	}
	
	private Obj? part2() {
		throw UnsupportedErr("write this!")
	}
	
}

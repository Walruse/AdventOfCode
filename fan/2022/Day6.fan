
class Day6 {
	
	private Buf? input
	
	Void main() {
		start := DateTime.now(1ns)
		input = `inputs/2022/day6.txt`.toFile.readAllBuf
		echo("Welcome to day 6!")
		echo("-----------------")
		echo("Part 1 answer: $part1")
		echo("Part 2 answer: $part2")
		echo("Computation time: ${(DateTime.now(1ns) - start)}")
	}
	
	private Obj? part1() {
		getPacket(4)
	}
	
	private Obj? part2() {
		getPacket(14)
	}
	
	private Int getPacket(Int numBytes) {
		doBreak := false
		val := null as Int
		for (i := 0; !doBreak && i < input.size - (numBytes - 1); i++) {
			chars := input.getRange(i..i+(numBytes - 1)).readAllStr
			if (chars.chars.unique.size == numBytes) {
				val = i+numBytes
				doBreak = true
			}
		}
		return val
	}
	
}

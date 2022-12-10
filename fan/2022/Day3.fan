
class Day3 {
	
	private Str[]? input
	
	Void main() {
		start := DateTime.now(1ns)
		input = `inputs/2022/day3.txt`.toFile.readAllLines
		echo("Welcome to day 3!")
		echo("-----------------")
		echo("Part 1 answer: $part1")
		echo("Part 2 answer: $part2")
		echo("Computation time: ${(DateTime.now(1ns) - start)}")
	}
	
	private Obj? part1() {
		prioritySum := 0
		input.each |bagStr| {
			allChars := bagStr.chars
			comp1 := allChars.getRange(0..((allChars.size / 2) - 1))
			comp2 := allChars.getRange((allChars.size / 2)..(allChars.size - 1))
			nonDupeChars := comp1.dup.removeAll(comp2)
			dupeChar := comp1.dup.removeAll(nonDupeChars).unique.first
			priority := dupeChar.toChar.isLower ? dupeChar - 70 - 26 : dupeChar - 38
			prioritySum += priority
		}
		return prioritySum
	}
	
	private Obj? part2() {
		prioritySum := 0
		for (i := 0; i < input.size; i += 3) {
			firstBag  := input[i  ].chars
			secondBag := input[i+1].chars
			thirdBag  := input[i+2].chars
			
			dupeChars := Int[,].addAll(firstBag).addAll(secondBag).addAll(thirdBag).unique
			badgeChar := dupeChars.find |char| { 
				[firstBag,secondBag,thirdBag].all |chars| { chars.contains(char) }
			}
			priority := badgeChar.toChar.isLower ? badgeChar - 96 : badgeChar - 38
			prioritySum += priority
		}
		return prioritySum
	}
	
}

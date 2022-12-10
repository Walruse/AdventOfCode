
class Day9 {
	
	private Str[]? input
	
	Void main() {
		start := DateTime.now(1ns)
		input = `inputs/2022/day9.txt`.toFile.readAllLines
		echo("Welcome to day 9!")
		echo("-----------------")
		echo("Part 1 answer: $part1")
		echo("Part 2 answer: $part2")
		echo("Computation time: ${(DateTime.now(1ns) - start)}")
	}
	
	private Obj? part1() {
		headXPos := 0
		headYPos := 0
		tailXPos := 0
		tailYPos := 0
		tailPositions := Str[,]
		debug := true
		input.each |cmdStr| {
			direction := cmdStr.split.first
			distance  := cmdStr.split.last.toInt
			
			distance.times { 
				switch (direction) {
					case "U":
						headYPos = headYPos + 1
					case "R":
						headXPos = headXPos + 1
					case "D":
						headYPos = headYPos - 1
					case "L":
						headXPos = headXPos - 1
				}
				
				xDiff := headXPos - tailXPos
				yDiff := headYPos - tailYPos
				
				if ((xDiff == 2 && yDiff == 1) || (yDiff == 2 && xDiff == 1)) {
					tailXPos++
					tailYPos++
				}
				
				if (xDiff == 2 && yDiff == 0)
					tailXPos++
				
				if ((xDiff == 2 && yDiff == -1) || (yDiff == -2 && xDiff == 1)) {
					tailXPos++
					tailYPos--
				}
				
				if (xDiff == 0 && yDiff == -2)
					tailYPos--
				
				if ((xDiff == -2 && yDiff == -1) || (yDiff == -2 && xDiff == -1)) {
					tailXPos--
					tailYPos--
				}
				
				if (xDiff == -2 && yDiff == 0)
					tailXPos--
				
				if ((xDiff == -2 && yDiff == 1) || (yDiff == 2 && xDiff == -1)) {
					tailXPos--
					tailYPos++
				}
				
				if (xDiff == 0 && yDiff == 2)
					tailYPos++
				
				tailPositions.add("${tailXPos}-${tailYPos}")
			}
		}
		return tailPositions.unique.size
	}
	
	private Obj? part2() {
		knots	 := [Int[0,0],Int[0,0],Int[0,0],Int[0,0],Int[0,0],Int[0,0],Int[0,0],Int[0,0],Int[0,0],Int[0,0]]
		tailPositions := Str[,]
		debug := true
		input.each |cmdStr| {
			direction := cmdStr.split.first
			distance  := cmdStr.split.last.toInt
			
			distance.times { 
				knots.size.times |i| {
					
					if (i == 0) {
						// Update the head position
						headXPos := knots.first.first
						headYPos := knots.first.last
						
						switch (direction) {
							case "U":
								headYPos = headYPos + 1
							case "R":
								headXPos = headXPos + 1
							case "D":
								headYPos = headYPos - 1
							case "L":
								headXPos = headXPos - 1
						}
						
						knots = knots.dup.set(0, [headXPos,headYPos])
					}
					
				// -----
					if (i > 0) {
						// Update the knot position
						
						x1 := knots[i - 1].first
						y1 := knots[i - 1].last
						
						x2 := knots[i].first
						y2 := knots[i].last
						
						xDiff := x1 - x2
						yDiff := y1 - y2
						
						if (xDiff > 2 || yDiff > 2)
							throw Err("diff too big: $i")
						
						tailXPos := x2
						tailYPos := y2
						if ((xDiff >= 2 && yDiff >= 1) || (yDiff >= 2 && xDiff >= 1)) {
							tailXPos++
							tailYPos++
						}
						if (xDiff >= 2 && yDiff == 0)
							tailXPos++
						
						if ((xDiff >= 2 && yDiff <= -1) || (yDiff <= -2 && xDiff >= 1)) {
							tailXPos++
							tailYPos--
						}
						if (xDiff == 0 && yDiff <= -2)
							tailYPos--
						if ((xDiff <= -2 && yDiff <= -1) || (yDiff <= -2 && xDiff <= -1)) {
							tailXPos--
							tailYPos--
						}
						if (xDiff <= -2 && yDiff == 0)
							tailXPos--
						if ((xDiff <= -2 && yDiff >= 1) || (yDiff >= 2 && xDiff <= -1)) {
							tailXPos--
							tailYPos++
						}
						if (xDiff == 0 && yDiff >= 2)
							tailYPos++
						
						knots = knots.set(i, [tailXPos,tailYPos])
					}
				}
				
				tailPositions.add("${knots.last.first}-${knots.last.last}")
			}
		}
		return tailPositions.unique.size
	}
	
}

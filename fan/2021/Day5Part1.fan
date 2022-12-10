class Day5Part1 {
	
	[Str:Int] allPoints := [:]
	
	private Void main() {
		input := `inputs/2021/day5.txt`.toFile.readAllLines
		input.each |line| { 
			splitCo := line.replace(">", "").split('-')
			splitA  := splitCo.first.split(',')
			x1		:= Int(splitA.first)
			y1		:= Int(splitA.last)
			splitB  := splitCo.last.split(',')
			x2		:= Int(splitB.first)
			y2		:= Int(splitB.last)
			
			if (x1 != x2 && y1 != y2)
				return
			
			if (x1 == x2 && y1 == y2)
				return
			
			// if co-ords are backwards
			if (x1 > x2 || y1 > y2) {
				tempX := x2
				tempY := y2
				x2 = x1
				y2 = y1
				x1 = tempX
				y1 = tempY
			}
			direction := x1 == x2 ? "y" : "x"
			distance  := direction == "y" ? y2 - y1 : x2 - x1
			distance   = distance.abs + 1
			
			points := Str[,]
			xpos   := x1
			ypos   := y1
			distance.times |cnt| { 
				points.add("$xpos,$ypos")
				if (direction == "x")
					xpos += 1
				else
					ypos += 1
			}
			
			points.each |serialPos| {
				allPoints[serialPos] = allPoints.getOrAdd(serialPos) { 0 } + 1
			}
			
		}
		dangerPoints := allPoints.findAll |num| { num >= 2 }
		
		echo(dangerPoints.size)
	}
	
}
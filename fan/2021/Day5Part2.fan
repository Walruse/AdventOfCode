class Day5Part2 {
	
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
			
			if (x1 == x2 && y1 == y2)
				return
			
			direction := null as Str
			if (x1 >  x2 && y1 >  y2) direction = "x- y-"
			if (x1 >  x2 && y1 <  y2) direction = "x- y+"
			if (x1 >  x2 && y1 == y2) direction = "x-"
			if (x1 <  x2 && y1 == y2) direction = "x+"
			if (x1 <  x2 && y1 >  y2) direction = "x+ y-"
			if (x1 <  x2 && y1 <  y2) direction = "x+ y+"
			if (x1 == x2 && y1 >  y2) direction = "y-"
			if (x1 == x2 && y1 <  y2) direction = "y+"
			
			distance  := (y2 - y1).abs.max((x2 - x1).abs)
			distance   = distance + 1
			
			points := Str[,]
			xpos   := x1
			ypos   := y1
			distance.times |cnt| { 
				points.add("$xpos,$ypos")
				directions := direction.split
				directions.each |dir| { 
					if (dir == "x+") xpos += 1
					if (dir == "x-") xpos -= 1
					if (dir == "y+") ypos += 1
					if (dir == "y-") ypos -= 1
				}
			}
			
			points.each |serialPos| {
				allPoints[serialPos] = allPoints.getOrAdd(serialPos) { 0 } + 1
			}
			
		}
		dangerPoints := allPoints.findAll |num| { num >= 2 }
		
		echo(dangerPoints.size)
	}
	
}
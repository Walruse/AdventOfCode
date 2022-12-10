
class Day3_Part2 {
	
	private Void main() {
		
		res1 := traverse(1,1)
		res2 := traverse(3,1)
		res3 := traverse(5,1)
		res4 := traverse(7,1)
		res5 := traverse(1,2)
		
		echo("1-$res1 2-$res2 3-$res3 4-$res4 5-$res5")
		
		finalRes := res1 * res2 * res3 * res4 * res5
		
		echo(finalRes.toStr)
	}
	
	private Int traverse(Int xDiff, Int yDiff) {
		input := `inputs/input_day3.txt`.toFile.readAllLines
		
		xLimit := input.first.size
		yLimit := input.size
		
		xChange := xDiff
		yChange := yDiff
		
		xPos := 1
		yPos := 1
		
		numTrees := 0
		
		while (yPos <= yLimit) {
			tile := input.get(yPos - 1).get(xPos - 1)
			if (tile == '#')
				numTrees++
			xPos += xChange
			yPos += yChange
			if (xPos > xLimit)
				xPos = (xPos - xLimit)
		}
		
		return numTrees
	}
	
}
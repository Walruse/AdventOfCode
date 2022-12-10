
class Day3_Part1 {
	
	private Void main() {
		input := `inputs/input_day3.txt`.toFile.readAllLines
		
		xLimit := input.first.size
		yLimit := input.size
		
		xChange := 3
		yChange := 1
		
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
		
		echo(numTrees.toStr)
	}
	
}
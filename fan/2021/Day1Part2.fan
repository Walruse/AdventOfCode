
class Day1Part2 {
	
	private Void main() {
		input := `inputs/2021/day1.txt`.toFile.readAllLines.map { Int(it) }
		
		vals := Int[input[0],input[1],input[2]]
		prevTot := null
		count := [,]
		input.each |val, idx| { 
			if (idx == 0 || idx == input.size - 1)
				return
			
			totalVal := vals[0] + vals[1] + vals[2]
			if (prevTot != null && prevTot < totalVal)
				count.add("increased")
			
			vals.removeAt(0)
			vals.addNotNull(input.getSafe(idx + 2))
			prevTot = totalVal
		}
		
		echo(count.size)
	}
	
}
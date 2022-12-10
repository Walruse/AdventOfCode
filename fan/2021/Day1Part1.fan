
class Day1Part1 {
	
	private Void main() {
		input := `inputs/2021/day1.txt`.toFile.readAllLines.map { Int(it) }
		count := input.map |val, idx| { 
			if (idx == 0)
				return null
			
			prevVal := input[idx-1]
			if (prevVal < val)
				return "increased"
			
			return null
		}.exclude { it == null}.size
		
		echo(count)
		
	}
	
}
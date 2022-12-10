
class Day2Part1 {
	
	private Void main() {
		input := `inputs/2021/day2.txt`.toFile.readAllLines
		
		hPos := 0
		vPos := 0
		
		input.each |cmd, idx| { 
			action := cmd.split.first
			distance := Int(cmd.split.last)
			
			switch (action) {
				case "forward":
					hPos += distance
				case "up":
					vPos -= distance
				case "down":
					vPos += distance
				default:
					throw Err("Unknown action ${action}")
			}
		}
		
		echo("hPos: $hPos | vPos: $vPos")
		echo("total: ${hPos * vPos}")
	}
}

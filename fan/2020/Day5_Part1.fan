
class Day5_Part1 {
	
	private Void main() {
		input := `inputs/input_day5.txt`.toFile.readAllLines
//		input := ["FFFFFFFLLL"] // 0-0
//		input := ["BBBBBBBRRR"] // 127-7
//		input := ["FBFBFBFLRL"] // 42-2
		
		output := input.map |Str s->Int| { 
			upperLimit 	:= 127
			gapSize		:= (upperLimit + 1) / 2
			Int? row
			Int? col
			
			s.getRange(0..6).each |Int char| { 
				echo("gap $gapSize")
				if (gapSize != 1) {
					if (char == 'F') {
						upperLimit = (upperLimit - gapSize)
					}
					echo("${upperLimit - (gapSize - 1)}-${upperLimit}")
					gapSize = gapSize / 2
				}
				else {
					if (char == 'F') {
						upperLimit = upperLimit - gapSize
					}
					echo("${upperLimit - (gapSize - 1)}-${upperLimit}")
					row = upperLimit
				}
			}
			
			upperLimit 	= 7
			gapSize		= (upperLimit + 1) / 2
			
			s.getRange(-3..-1).each |Int char| {
				if (gapSize != 1) {
					if (char == 'L') {
						upperLimit = (upperLimit - gapSize)
					}
					echo("${upperLimit - (gapSize - 1)}-${upperLimit}")
					gapSize = gapSize / 2
				}
				else {
					if (char == 'L') {
						upperLimit = upperLimit - gapSize
					}
					echo("${upperLimit - (gapSize - 1)}-${upperLimit}")
					col = upperLimit
				}
			}
			echo("$row $col")
			return (row * 8) + col
		}
		
		echo(output.sortr.first.toStr)
	}
	
}
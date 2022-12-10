
class Day5_Part2 {
	
	private Void main() {
		input := `inputs/input_day5.txt`.toFile.readAllLines
//		input := ["FFFFFFFLLL"] // 0-0
//		input := ["BBBBBBBRRR"] // 127-7
//		input := ["FBFBFBFLRL"] // 42-2
		
		output := Int[,]
		
		output.addAll(input.map |Str s->Int| { 
			upperLimit 	:= 127
			gapSize		:= (upperLimit + 1) / 2
			
			s.getRange(0..6).each |Int char| { 
				if (char == 'F')
					upperLimit = (upperLimit - gapSize)
				gapSize = gapSize / 2
			}
			row := upperLimit
			
			upperLimit 	= 7
			gapSize		= (upperLimit + 1) / 2
			
			s.getRange(-3..-1).each |Int char| {
				if (char == 'L')
					upperLimit = (upperLimit - gapSize)
				gapSize = gapSize / 2
			}
			col := upperLimit
			
			return (row * 8) + col
		})
		
		output.sort
		
		answer := output.eachWhile |Int num, Int idx->Int?| { 
			if ((output[idx + 1] - num) != 1)
				return num + 1
			return null
		}
		echo(output.toStr)
		echo("$answer")
	}
	
}

class Day3Part2 {
	
	private Void main() {
		input := `inputs/2021/day3.txt`.toFile.readAllLines
		
		vals :=(Int[]) [true, false].map |Bool isO2Rating->Int| {
			12.times |bitDepth| {
				if (input.size == 1)
					return
				bitMask := calculateBitMask(input, bitDepth, isO2Rating)
				input	 = input.findAll |binStr| { binStr[bitDepth].toChar == bitMask }
			}
			
			finalInput := input
			input = `inputs/2021/day3.txt`.toFile.readAllLines
			return finalInput.first.toInt(2)
		}
		
		echo(vals.first * vals.last)
	}
	
	private Str calculateBitMask(Str[] input, Int depth, Bool isO2Rating) {
		bitTot := 0
		input.each |binStr| { bitTot += binStr[depth].toChar.toInt(2) }
		if (bitTot.toFloat > (input.size / 2f))
			return isO2Rating ? "1" : "0"
		return isO2Rating ? "0" : "1"
	}
	
}

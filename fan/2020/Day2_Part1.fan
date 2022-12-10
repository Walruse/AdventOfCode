
class Day2_Part1 {
	
	private Void main() {
		
		
		input := `inputs/input.txt`.toFile.readAllLines
		
		numValid := 0
		
		input.each |Str fullPass| { 
			key := fullPass.split(':').first
			pass := fullPass.split(':').last.trim
			rangeStart := key.split('-').first.toInt
			rangeEnd := key.split('-').last.split().first.toInt
			char	:= key.split().last.chars.first
//			echo("key: $key pass: $pass rangeStart $rangeStart rangeEnd $rangeEnd char $char")
			
			matchingChars := pass.chars.findAll |Int passChar->Bool| { 
				return passChar == char
			}
			numChars := matchingChars.size
			
			if (numChars <= rangeEnd && numChars >= rangeStart)
				numValid++
		}
		
		echo(numValid.toStr)
	}
	
}
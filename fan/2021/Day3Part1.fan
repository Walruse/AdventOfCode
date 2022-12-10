
class Day3Part1 {
	
	private Void main() {
		input := `inputs/2021/day3.txt`.toFile.readAllLines
		
		bitTots := Int[0,0,0,0,0,0,0,0,0,0,0,0]
		input.each |binStr| { 
			binStr.each |char, idx| { bitTots.set(idx, bitTots[idx] + char.toChar.toInt(2)) }
		}
		gamma := bitTots.map |totBits| { 
			if (totBits > (input.size / 2))  
				return "1"
			
			return "0"
		}.join("").toInt(2)
		epsilon := Int.fromStr("111111111111", 2) - gamma
		
		echo("gamma: $gamma | epsilon: $epsilon")
		echo("total: ${gamma * epsilon}")
	}
}

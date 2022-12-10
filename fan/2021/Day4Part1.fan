
class Day4Part1 {
	
	BingoBoard[] boards := BingoBoard[,]
	
	private Void main() {
		input 	:= `inputs/2021/day4.txt`.toFile.readAllLines
		allNums := input.removeAt(0).split(',').map { Int(it) }
		
		(input.size / 6).times { 
			boards.add(BingoBoard(input[(6 * it)..((6 * (it + 1)) - 1)]))
		}
		echo("setup complete!")
		
		curNum := 0
		
		score :=(Int?) allNums.eachWhile |bingoNum| {
			curNum = bingoNum
			return boards.eachWhile |board| { 
				board.checkNum(bingoNum) 
				if (board.isComplete) {
					echo("====WINNER====")
					echo(board.toStr)
					echo("==============")
					return board.totalScore
				}
				return null
			}
		} ?: 0
		
		echo(score * curNum)
	}
	
}

class BingoBoard {
	
	Int[] 	nums
	Bool[] 	checks
	
	new make(Str[] input) {
		if (input.size != 6)
			throw Err("Incorrect number of lines to build board: $input.size")
		
		nums   = Int[,]
		checks = Bool[,]
		
		input.each |ln| {
			splitLn := ln.split
			splitLn.exclude { it.trimToNull == null }.each {
				nums 	= nums	.add(Int.fromStr(it, 10))
				checks 	= checks.add(false)
			}
		}
		
		if (nums.size != 25)
			throw Err("Incorrect number of nums on bingo card: $nums.size")
	}
	
	Void checkNum(Int num) {
		idx := nums.findIndex { it == num }
		if (idx != null)
			checks.set(idx, true)
	}
	
	Int totalScore() {
		score := 0
		checks.each |chk, idx| {
			if (!chk)
				score += nums[idx]
		}
		return score
	}
	
	Bool isComplete() {
		[1,2,3,4,5].any { isRowComplete(it) || isColComplete(it) }
	}
	
	Bool isRowComplete(Int rowNum) {
		checks[(5 * (rowNum - 1))..((5 * rowNum) - 1)].all { it == true }
	}
	
	Bool isColComplete(Int colNum) {
		[-1,4,9,14,19].map |pos| { checks[pos + colNum] }.all { it == true }
	}
	
	override Str toStr() {
		pattern := "00"
		out := ""
		out += (checks[0] ? "x" : "o") + nums[0].toLocale(pattern) + " "
		out += (checks[1] ? "x" : "o") + nums[1].toLocale(pattern) + " "
		out += (checks[2] ? "x" : "o") + nums[2].toLocale(pattern) + " "
		out += (checks[3] ? "x" : "o") + nums[3].toLocale(pattern) + " "
		out += (checks[4] ? "x" : "o") + nums[4].toLocale(pattern) + "\n"
		
		out += (checks[5] ? "x" : "o") + nums[5].toLocale(pattern) + " "
		out += (checks[6] ? "x" : "o") + nums[6].toLocale(pattern) + " "
		out += (checks[7] ? "x" : "o") + nums[7].toLocale(pattern) + " "
		out += (checks[8] ? "x" : "o") + nums[8].toLocale(pattern) + " "
		out += (checks[9] ? "x" : "o") + nums[9].toLocale(pattern) + "\n"
		
		out += (checks[10] ? "x" : "o") + nums[10].toLocale(pattern) + " "
		out += (checks[11] ? "x" : "o") + nums[11].toLocale(pattern) + " "
		out += (checks[12] ? "x" : "o") + nums[12].toLocale(pattern) + " "
		out += (checks[13] ? "x" : "o") + nums[13].toLocale(pattern) + " "
		out += (checks[14] ? "x" : "o") + nums[14].toLocale(pattern) + "\n"
		
		out += (checks[15] ? "x" : "o") + nums[15].toLocale(pattern) + " "
		out += (checks[16] ? "x" : "o") + nums[16].toLocale(pattern) + " "
		out += (checks[17] ? "x" : "o") + nums[17].toLocale(pattern) + " "
		out += (checks[18] ? "x" : "o") + nums[18].toLocale(pattern) + " "
		out += (checks[19] ? "x" : "o") + nums[19].toLocale(pattern) + "\n"
		
		out += (checks[20] ? "x" : "o") + nums[20].toLocale(pattern) + " "
		out += (checks[21] ? "x" : "o") + nums[21].toLocale(pattern) + " "
		out += (checks[22] ? "x" : "o") + nums[22].toLocale(pattern) + " "
		out += (checks[23] ? "x" : "o") + nums[23].toLocale(pattern) + " "
		out += (checks[24] ? "x" : "o") + nums[24].toLocale(pattern)
		
		return out
	}
	
}
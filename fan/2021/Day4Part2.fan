
class Day4Part2 {
	
	BingoBoard[] boards := BingoBoard[,]
	
	private Void main() {
		input 	:= `inputs/2021/day4.txt`.toFile.readAllLines
		allNums := input.removeAt(0).split(',').map { Int(it) }
		
		(input.size / 6).times { 
			boards.add(BingoBoard(input[(6 * it)..((6 * (it + 1)) - 1)]))
		}
		echo("setup complete!")
		
		curNum 		:= 0
		lastBoard	:=(BingoBoard?) allNums.eachWhile |bingoNum| {
			curNum = bingoNum
			if (boards.size == 1) {
				boards.first.checkNum(bingoNum)
				if (boards.first.isComplete)
					return boards.first
				return null
			}
			
			boards = boards.map |board| { 
				board.checkNum(bingoNum)
				if (board.isComplete)
					return null
				return board
			}.exclude { it == null }
			
			return null
		}
		
		echo(lastBoard.totalScore * curNum)
	}
	
}

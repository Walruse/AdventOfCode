
class Day8 {
	
	private Str[]? input
	private Buf[] verts := Buf[,]
	private Buf[] horis := Buf[,]
	
	Void main() {
		start := DateTime.now(1ns)
		input = `inputs/2022/day8.txt`.toFile.readAllLines
		parseForest()
		echo("Welcome to day 8!")
		echo("-----------------")
		echo("Part 1 answer: $part1")
		echo("Part 2 answer: $part2")
		echo("Computation time: ${(DateTime.now(1ns) - start)}")
	}
	
	private Obj? part1() {
		tot := 0
		horis.each |row, yIdx| {
			row.size.times |xIdx| { 
				isVis := isVisible(xIdx, yIdx)
				if (isVis) {
					tot++
				}
			}
		}
		return tot
	}
	
	private Obj? part2() {
		scores := Int[,]
		horis.each |row, yIdx| { 
			row.size.times |xIdx| { 
				scores.add(calcScore(xIdx, yIdx))
			}
		}
		return scores.sort.last
	}
	
	private Void parseForest() {
		input.each |row, yIdx| { 
			horis.add(row.toBuf)
			row.each |char, xIdx| { 
				if (verts.size < xIdx + 1)
					verts.add(Buf())
				verts[xIdx].writeChar(char)
			}
		}
	}
	
	private Bool isVisible(Int xIdx, Int yIdx) {
		if (xIdx == 0 || xIdx == verts.size - 1)
			return true
		
		if (yIdx == 0 || yIdx == horis.size - 1)
			return true
		
		row := horis[yIdx]
		col := verts[xIdx]
		
		visHorizontal := checkVis(row, xIdx)
		visVertical := checkVis(col, yIdx)
		return visHorizontal || visVertical
	}
	
	private Bool checkVis(Buf trees, Int idx) {
		preTrees  := trees.getRange(0..(idx - 1)).readAllStr
		postTrees := trees.getRange((idx + 1)..-1).readAllStr
		return preTrees.all |char| { char < trees[idx] } || postTrees.all |char| { char < trees[idx] }
	}
	
	private Int calcScore(Int xIdx, Int yIdx) {
		if (xIdx == 0 || xIdx == verts.size - 1)
			return 0
		
		if (yIdx == 0 || yIdx == horis.size - 1)
			return 0
		
		row := horis[yIdx]
		col := verts[xIdx]
		
		horScore := calcVal(row, xIdx)
		verScore := calcVal(col, yIdx)
		return horScore * verScore
	}
	
	private Int calcVal(Buf trees, Int idx) {
		preTreesBuf  := trees.getRange(0..(idx - 1))
		preTreesStr  := ""
		for (i := preTreesBuf.size - 1; i >= 0; i--) {
			preTreesStr += preTreesBuf[i].toChar
		}
		postTrees := trees.getRange((idx + 1)..-1).readAllStr
		preNum    := preTreesStr.chars.findIndex |char| { char >= trees[idx] }?.plus(1) ?: preTreesBuf.size
		postNum   := postTrees.chars.findIndex |char| { char >= trees[idx] }?.plus(1) ?: postTrees.size
		return preNum * postNum
	}
	
}


class Day12 {
	
	private Buf[]? input
	
	Void main() {
		start := DateTime.now(1ns)
		input = `inputs/2022/day12.txt`.toFile.readAllLines.map { it.toBuf }
		echo("Welcome to day 12!")
		echo("-----------------")
		echo("Part 1 answer: $part1")
		echo("Part 2 answer: $part2")
		echo("Computation time: ${(DateTime.now(1ns) - start)}")
	}
	
	private Obj? part1() {
		startY := input.findIndex { it.dup.readAllStr.contains("S") }
		startX := input[startY].dup.readAllStr.index("S")
		
		curHeight 	:= "a".chars.first
		curX		:= startX
		curY		:= startY
		
		finishY := input.findIndex { it.dup.readAllStr.contains("E") }
		finishX := input[startY].dup.readAllStr.index("E")
		
		echo([curX,curY])
		echo([finishX,finishY])
		
		nodesToConsider := Int[][,]
		nodesUsed := [[curX,curY]]
		solutionNodes := [[curX,curY]]
		steps := 0
		
		a := 0
		
		echo("==============")
		while (curX != finishX || curY != finishY) {
			echo("cur: " + [curX,curY,steps])
			echo("nodes used: " + nodesUsed)
			echo("nodes to consider: " + nodesToConsider)
			// check adjacent nodes
			// if no nodes viable
			//  - update curPos to most recently valid node
			// add viable nodes to nodesToConsider (prioritise increase in height)
			// set curPos to top valid node
			adjNodes := [
				[curX - 1, curY, curX, curY],
				[curX + 1, curY, curX, curY],
				[curX, curY - 1, curX, curY],
				[curX, curY + 1, curX, curY]
			].findAll |coords| { 
				if (coords[0] < 0 || coords[1] < 0)
					return false
				
				if (coords[0] >= input[0].size || coords[1] >= input.size)
					return false
				
				if (nodesUsed.contains([coords[0],coords[1]]))
					return false
				
				if (nodesToConsider.find |conCoords| { conCoords[0] == coords[0] && conCoords[1] == coords[1] } != null)
					return false
				
				height := getHeight(coords)
				if (height > curHeight + 1)
					return false
				
				return true
			}
			adjNodes.sortr |co1, co2| { finishY - co1[1] <=> finishY - co2[1] }
			adjNodes.sortr |co1, co2| { finishX - co1[0] <=> finishX - co2[0] }
			adjNodes.sort |co1, co2| { getHeight(co1) <=> getHeight(co2) }
			echo("new nodes to consider: " + adjNodes)
			nodesToConsider.addAll(adjNodes)
			if (adjNodes.isEmpty) {
				returnCoords := [nodesToConsider.last[2],nodesToConsider.last[3]]
				echo("return coords: " + returnCoords)
				rangeToRemove := (solutionNodes.findIndex { it[0] == returnCoords[0] && it[1] == returnCoords[1] } + 1)..(solutionNodes.size - 1)
//				nodesUsed.removeRange(rangeToRemove)
				solutionNodes.removeRange(rangeToRemove)
				steps = steps - ((rangeToRemove.end - rangeToRemove.start) + 1)
			}
				
			newPos := nodesToConsider.removeAt(-1)
			curX = newPos[0]
			curY = newPos[1]
			curHeight = getHeight(newPos)
			solutionNodes.add([curX,curY])
			nodesUsed.add([curX,curY])
			steps++
			a++
//			if (a > 40)
//				throw Err("errs")
			echo("------------")
		}
		
		patt := "MM-DD-hh-mm-ss"
		file := `outputs/2022/`.plusName("day12-${DateTime.now.toLocale(patt)}-path.txt").toFile
		newGrid :=(Buf[]) `inputs/2022/day12.txt`.toFile.readAllLines.map { it.toBuf }
		solutionNodes.each |Int[] coords| { newGrid[coords[1]][coords[0]] = "X".chars.first }
		file.delete
		output := file.create.open
		newGrid.each |Buf buf| { output.writeChars(buf.readAllStr).writeChars("\n") }
		output.close
		
		file2 := `outputs/2022/`.plusName("day12-${DateTime.now.toLocale(patt)}-used.txt").toFile
		newGrid2 :=(Buf[]) `inputs/2022/day12.txt`.toFile.readAllLines.map { it.toBuf }
		nodesUsed.each |Int[] coords| { newGrid2[coords[1]][coords[0]] = "X".chars.first }
		file2.delete
		output2 := file2.create.open
		newGrid2.each |Buf buf| { output2.writeChars(buf.readAllStr).writeChars("\n") }
		output2.close
		
		return [curX,curY]
	}
	
	private Int getHeight(Int[] coords) {
		input[coords[1]][coords[0]]
	}
	
	private Obj? part2() {
		throw UnsupportedErr("write this!")
	}
	
}

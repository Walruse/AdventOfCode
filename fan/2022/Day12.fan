
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
		nodeGrid 	:= NodeGrid.make(input, 'S', 'E')
		startNode 	:= nodeGrid.getStartNode
		endNode 	:= nodeGrid.getEndNode
		
		curNode		:= startNode
		
		while (!endNode.isVisited && !nodeGrid.allVisited) {
			neighbours := nodeGrid.getNeighbours(curNode)
			neighbours.each { 
				distFromCur := curNode.tentDis + 1
				if (it.tentDis > distFromCur)
					it.tentDis = distFromCur
			}
			curNode.isVisited = true
			if (!nodeGrid.allVisited && !endNode.isVisited)
				curNode = nodeGrid.getSmallestNode
			
		}
		
		nodeGrid.writeShortestPathToFile
		
		return endNode.tentDis
	}
	
	private Obj? part2() {
		nodeGrid 	:= NodeGrid.makeInverse(`inputs/2022/day12.txt`.toFile.readAllLines.map { it.toBuf }, 'E', 'S')
		startNode 	:= nodeGrid.getStartNode
		
		curNode		:= startNode
		doBreak 	:= false
		
		step := 0
		
		while (!doBreak) {
			neighbours := nodeGrid.getNeighbours(curNode)
			neighbours.each {
				distFromCur := curNode.tentDis + 1
				if (it.tentDis > distFromCur)
					it.tentDis = distFromCur
			}
			curNode.isVisited = true
			if (curNode.height == 'a')	
				doBreak = true
			
			step++
			
			if (!doBreak)
				curNode = nodeGrid.getSmallestNode
		}
		
		nodeGrid.writeShortestPathToFile(2)
		
		return nodeGrid.getEndNode.tentDis
	}
	
	
}

class NodeGrid {
	
	Node[] 	nodes
	Bool 	isInverse := false
	
	new make(Buf[] input, Int startChar, Int endChar) {
		this.nodes = Node[,]
		input.each |row, idx| {
			for (i := 0; i < row.size; i++) {
				char := row[i]
				isStart := char == startChar
				isEnd 	:= char == endChar
				if (isStart)
					char = 'a'
				if (isEnd)
					char = 'z'
				nodes.add(Node(i, idx, char, isStart, isEnd))
			}
		}
	}
	
	new makeInverse(Buf[] input, Int startChar, Int endChar) {
		this.nodes = Node[,]
		input.each |row, idx| {
			for (i := 0; i < row.size; i++) {
				char := row[i]
				isStart := char == startChar
				isEnd 	:= char == endChar
				if (isStart)
					char = 'z'
				if (isEnd)
					char = 'a'
				nodes.add(Node(i, idx, char, isStart))
			}
		}
		this.isInverse = true
	}
	
	Node[] getShortestPath() {
		curNode 	:= getEndNode
		nodes		:= [curNode]
		while (curNode.tentDis != 0) {
			neighbours 	:= getNeighbours(curNode, true)
			prevNode 	:= neighbours.find |node| { node.tentDis == (curNode.tentDis - 1) }
			nodes.insert(0, prevNode)
			curNode = prevNode
		}
		return nodes
	}
	
	Node getSmallestNode() {
		nodes.findAll { !it.isVisited }.sort |n1, n2| { n1.tentDis <=> n2.tentDis }.first
	}
	
	Node getStartNode() {
		nodes.find { it.isStart }
	}
	
	Node getEndNode() {
		this.isInverse ? nodes.find { it.height == 'a' && it.isVisited } : nodes.find { it.isEnd }
	}
	
	@Operator
	Node get(Int[] coords) {
		nodes.find { it.posX == coords[0] && it.posY == coords[1] }
	}
	
	Node[] getNeighbours(Node baseNode, Bool ignoreHeight := false) {
		nodes.findAll |node| { 
			isX := (node.posX - baseNode.posX).abs <= 1 && node.posY == baseNode.posY
			isY := (node.posY - baseNode.posY).abs <= 1 && node.posX == baseNode.posX
			if (node.posX == baseNode.posX && node.posY == baseNode.posY)
				return false
			
			if (!isX && !isY)
				return false
			
			if (isInverse) {
				if (baseNode.height - node.height > 1 && !ignoreHeight)
					return false
			} else {
				if (node.height - baseNode.height > 1 && !ignoreHeight)
					return false
			}
			
			if (ignoreHeight && node.height == 'a' && node.posX != 0)
				return false
			
			return true
		}
	}
	
	Bool allVisited() {
		nodes.find { !it.isVisited } == null
	}
	
	Void writeShortestPathToFile(Int partNum := 1) {
		dir			:= `outputs/2022/day12/`.toFile
		numOutputs 	:= dir.listFiles.size
		file 		:= dir.uri.plusName("day12_${partNum}-path-${numOutputs}.txt").toFile
		initLines 	:=(Buf[]) `inputs/2022/day12.txt`.toFile.readAllLines.map { it.toBuf }
		file.delete
		fileBuf := file.create.open
		getShortestPath.each |node| { 
			initLines[node.posY][node.posX] = '#'
		}
		initLines.each {
			fileBuf.writeChars(it.readAllStr).writeChars("\n")
		}
		fileBuf.close
	}
	
	Void writeToFile() {
		dir			:= `outputs/2022/day12/`.toFile
		numOutputs 	:= dir.listFiles.size
		file 		:= dir.uri.plusName("day12-${numOutputs}.txt").toFile
		initLines 	:=(Buf[]) `inputs/2022/day12.txt`.toFile.readAllLines.map { it.toBuf }
		file.delete
		fileBuf := file.create.open
		nodes.each {
			str := it.tentDis == 99999999999 ? it.height.toChar.padl(3) : it.tentDis.toLocale("##0").padl(3)
			fileBuf.writeChars("|${str}")
			if (it.posX == 171)
				fileBuf.writeChars("\n")
			
		}
		fileBuf.close
		echo("Written output to: ${file}")
	}
	
}

class Node {
	
	Int posX
	Int posY
	Int height
	Int tentDis 	:= 99999999999
	Bool isVisited 	:= false
	Bool isStart	:= false
	Bool isEnd		:= false
	
	new make(Int posX, Int posY, Int height, Bool isStart, Bool isEnd) {
		this.posX 		= posX
		this.posY 		= posY
		this.height 	= height
//		if (this.height == 'a' && this.posX > 0)
//			this.height = 100
		if (isStart) {
			this.tentDis 	= 0
			this.isStart  	= true
		}
		if (isEnd)
			this.isEnd		= true
	}
	
	new makeInverse(Int posX, Int posY, Int height, Bool isStart) {
		this.posX 		= posX
		this.posY 		= posY
		this.height 	= height
		if (isStart) {
			this.tentDis 	= 0
			this.isStart  	= true
		}
	}
	
	override Str toStr() {
		str := "Node ("
		str += posX.toLocale("##0").padl(3) + "-"
		str += posY.toLocale("##0").padl(3) + "): "
		str += "[" + height.toChar + "] "
		str += "[" + tentDis + "] "
		if (this.isStart)
			str += "[isStart] "
		if (this.isEnd)
			str += "[isEnd] "
		return str
	}
	
}
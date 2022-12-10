
class Day10 {
	
	private Str[]? input
	private Int[]? regHistory
	
	Void main() {
		start := DateTime.now(1ns)
		input = `inputs/2022/day10.txt`.toFile.readAllLines
		echo("Welcome to day 10!")
		echo("-----------------")
		echo("Part 1 answer: $part1")
		echo("Part 2 answer: $part2")
		echo("Computation time: ${(DateTime.now(1ns) - start)}")
	}
	
	private Obj? part1() {
		newPc := Computer(input)
		while (newPc.hasCmd) {
			newPc.cycle
		}
		this.regHistory = newPc.regHistory
		total := 0
		[20, 60, 100, 140, 180, 220].each { 
			total += (newPc.regHistory[it - 1] * it)
		}
		return total
	}
	
	private Obj? part2() {
		screen := "\n"
		regHistory.each |reg, idx| {
			relPixel := idx%40
			spritePixels := [reg - 1, reg, reg + 1]
			if (spritePixels.contains(relPixel))
				screen += "#"
			else
				screen += "."
			
			if (relPixel == 39)
				screen += "\n"
		}
		screen += "\n"
		return screen
	}
	
}

class Computer {
	
	private Command[]	commandQueue
	private Command? 	curCmd
	private Int?		regMem
	private Int			counter := 0
	
	Int[]	regHistory 	:= Int[,]
	Int 	register 	:= 1
	Int 	cycleNum 	:= 0
	
	new make(Str[] commands) {
		this.commandQueue = commands.map { Command(it) }
	}
	
	Bool hasCmd() {
		commandQueue.size > 0
	}
	
	Void cycle() {
		if (curCmd == null) {
			curCmd = commandQueue.removeAt(0)
			counter = 0
			if (regMem != null)
				register = regMem
			regMem = null
		} else {
			cycleNum++
			counter++
			
			if (counter == 1 && curCmd.type.isAddx)
				regMem = register + curCmd.value
			
			regHistory.add(register)
			
			if (counter == curCmd.type.cd)
				curCmd = null
		}
	}
}

class Command {
	
	Int? 		value
	CmdType	 	type
	
	new make(Str cmdStr) {
		this.value = cmdStr.split.getSafe(1, null)?.toInt
		this.type  = value == null ? CmdType.noop : CmdType.addx
	}
}

enum class CmdType {
	noop(1),
	addx(2)
	
	const Int cd
	
	private new make(Int cd) {
		this.cd = cd
	}
	
	Bool isAddx() {
		this.name == "addx"
	}
	
	Bool isNoop() {
		this.name == "noop"
	}
}
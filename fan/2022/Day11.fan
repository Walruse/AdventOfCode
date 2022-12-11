
class Day11 {

	private Str[]? input
	
//	Monkey[] monkeys := Monkey[,]
	
	Void main() {
		start := DateTime.now(1ns)
		input = `inputs/2022/day11.txt`.toFile.readAllStr.split('-')
//		monkeys = input.map { Monkey(it) } // Moved this to inside each method, wasn't re-parsing monkeys for part 2
		echo("Welcome to day 11!")
		echo("-----------------")
		echo("Part 1 answer: $part1")
		echo("Part 2 answer: $part2")
		echo("Computation time: ${(DateTime.now(1ns) - start)}")
	}
	
	private Obj? part1() {
		monkeys :=(Monkey[]) input.map { Monkey(it) }
		20.times |i| {
			monkeys.each { 
				itemsToThrow := it.takeTurn
				itemsToThrow.each |items, monkeyIdx| { 
					monkeys[monkeyIdx].addItems(items)
				}
			}
		}
		
		monkeys.sortr |monk1, monk2| { monk1.numInspected <=> monk2.numInspected }
		return monkeys[0].numInspected * monkeys[1].numInspected
	}
	
	private Obj? part2() {
		monkeys :=(Monkey[]) input.map { Monkey(it) }
		reliefMod := 1
		monkeys.each { reliefMod = reliefMod * it.divisor }
		10000.times |i| {
			monkeys.each { 
				itemsToThrow := it.takeTurn(reliefMod)
				itemsToThrow.each |items, monkeyIdx| { 
					monkeys[monkeyIdx].addItems(items)
				}
			}
		}
		
		monkeys.sortr |monk1, monk2| { monk1.numInspected <=> monk2.numInspected }
		return monkeys[0].numInspected * monkeys[1].numInspected
	}
	
}

class Item {
	
	Int worryLevel
	
	new make(Int worryLevel) {
		this.worryLevel = worryLevel
	}
	
	Void calcRelief(Int? reliefMod) {
		if (reliefMod == null) {
			worryLevel = (worryLevel / 3.0f).floor.toInt
			return
		}
		
		if (reliefMod == -1)
			return
		
		worryLevel = (worryLevel % reliefMod)
		return
	}
	
	Void inspectItem(|Int->Int| inspectFn) {
		worryLevel = inspectFn(worryLevel)
	}
	
	override Str toStr() {
		worryLevel.toStr
	}
}

class Monkey {
	
	Item[] 		items
	|Int->Int| 	operationFn
	|Int->Bool| testFn
	Bool:Int	targetMonkey
	Int			numInspected := 0
	
	Int			divisor
	
	new make(Str monkeyStr) {
		lines 				:= monkeyStr.split("\n".chars.first)
		this.items 	 		= parseItems(lines[1])
		this.operationFn 	= parseOpFn(lines[2])
		this.testFn 		= parseTestFn(lines[3])
		this.targetMonkey 	= parseTargetMonkey(lines[4..5])
		this.divisor		= lines[3].split.last.toInt
	}
	
	override Str toStr() {
		"""${items} ${numInspected}\n"""
	}
	
	Int totalWorryLevel() {
		items.reduce(0) |tot, item| { (Int)tot + item.worryLevel }
	}
	
	Int:Item[] takeTurn(Int? reliefMod := null) {
		itemsToThrow := Int:Item[][:]
		items.each |item, idx| { 
			item.inspectItem(operationFn)
			item.calcRelief(reliefMod)
			monkeyIdx := targetMonkey[testFn(item.worryLevel)]
			itemsToThrow[monkeyIdx] = itemsToThrow.getOrAdd(monkeyIdx) |->Item[]| { return Item[,] }.add(item)
			numInspected++
		}
		items = Item[,]
		return itemsToThrow
	}
	
	Void addItems(Item[] itemsToAdd) {
		this.items.addAll(itemsToAdd)
	}
	
	static |Int->Int| parseOpFn(Str opLine) {
		opData 		:= opLine.split
		if (opData.last == "old" && opData[-3] == "old")
			return |Int i->Int| { return (i * i) }
		num 		:= Int(opData.last)
		return opData[-2] == "*"
			? |Int i->Int| { return (i * num) }
			: |Int i->Int| { return (i + num) }
	}
	
	static Item[] parseItems(Str itemsLine) {
		itemsLine.split(':').last.split(',').map { Item(Int(it)) }
	}
	
	static |Int->Bool| parseTestFn(Str testLine) {
		divisor := testLine.split.last.toInt
		return |Int i->Bool| { (i.abs % divisor) == 0 }
	}
	
	static Bool:Int parseTargetMonkey(Str[] targetLines) {
		map := Bool:Int[:]
		map.set(true, (targetLines.find { it.contains("true") }.split.last.toInt))
		map.set(false, (targetLines.find { it.contains("false") }.split.last.toInt))
		return map
	}
}

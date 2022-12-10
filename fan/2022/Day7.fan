
class Day7 {
	
	private Str[]?  	input
	private Uri?		cursor
	private [Str:Int]? 	sizes
	
	Void main() {
		start := DateTime.now(1ns)
		input = `inputs/2022/day7.txt`.toFile.readAllLines
		echo("Welcome to day 7!")
		echo("-----------------")
		echo("Part 1 answer: $part1")
		echo("Part 2 answer: $part2")
		echo("Computation time: ${(DateTime.now(1ns) - start)}")
	}
	
	private Obj? part1() {
		createFiles
		
		sizes = Str:Int[:]
		`inputs/2022/temp/`.toFile.walk |file| { 
			if (file.isDir)
				sizes.add(file.path.getRange(2..-1).join("-"), 0)
			else {
				fileSize := Int(file.readAllStr)
				dirs := file.path.getRange(2..-2)
				dirNameFull := dirs.first
				dirs.each |dirName| {
					if (dirName != dirNameFull)
						dirNameFull += "-${dirName}"
					dirSize := sizes[dirNameFull]
					sizes[dirNameFull] = dirSize + fileSize
				}
			}
		}
		
		total := 0
		sizes.each |size| { 
			if (size <= 100000)
				total += size
		}
		return total
	}
	
	private Obj? part2() {
		minToDelete := 30000000 - (70000000 - sizes["temp"])
		
		vals := Int[,]
		sizes.each |v, k| { 
			vals.add(v)
		}
		sortedVals := vals.dup.sort
		amountToDelete := sortedVals.find { it >= minToDelete }
		return amountToDelete
	}
	
	private Void createFiles() {
		`inputs/2022/temp/`.toFile.list.each { it.delete }
		input.each |cmdStr| { 
			if (cmdStr.startsWith("\$"))
				parseCommand(cmdStr)
			else
				parseUri(cmdStr)
		}
	}
	
	Void parseUri(Str uriStr) {
		path := uriStr.split
		if (path.first == "dir")
			cursor.toFile.createDir(path[1])
		else {
			cursor.toFile.createFile(path[1]).writeObj(Int.fromStr(path[0]))
		}
	}
	
	Void parseCommand(Str command) {
		path := command.split
		if (path[1] == "ls")
			return
		
		switch (path[2]) {
			case "/":
				cursor = `inputs/2022/temp/`
			case "..":
				cursor = pathToUri(cursor.path.getRange(0..-2))
			default:
				cursor = cursor.plusName(path[2]).plusSlash
		}
	}
	
	private Uri pathToUri(Str[] path) {
		uri := `${path.first}`
		path.removeAt(0)
		path.each { uri = uri.plusSlash.plusName(it) }
		return uri.plusSlash
	}
	
}

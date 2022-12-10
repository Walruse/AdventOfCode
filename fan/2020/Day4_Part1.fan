
class Day4_Part1 {
	
	private Void main() {
		input := `inputs/input_day4.txt`.toFile.readAllLines
		splitInputs := Str[,]
		
		input.each { splitInputs.addAll(it.split) }
		
		indexList := Int[,]
		
		splitInputs.each |Str s, Int idx| { 
			if (s == "")
				indexList.add(idx)
		}
		
		documents := [Str:Str][,]
		
		indexList.each |Int inpIdx, Int idx| { 
			if (idx == 0) {
				if (inpIdx > 6) {
					documents.add(createDocument(splitInputs.getRange(0..inpIdx)))					
				}
			}
			else {
				if ((inpIdx - indexList[idx - 1]) > 7) {
					tempDoc := createDocument(splitInputs.getRange(indexList[idx - 1]..inpIdx))
					if (tempDoc != null)
						documents.add(tempDoc)
				}
			}
		}
		if (splitInputs.size - indexList.last > 7) {
			tempDoc := createDocument(splitInputs.getRange(indexList[-1]..-1))
				if (tempDoc != null)
					documents.add(tempDoc)
		}
		
		echo(documents.size.toStr)
	}
	
	[Str:Str]? createDocument(Str[] info) {
		doc := Str:Str[:]
		info.each |Str s| {
			if (s != "")
				doc.getOrAdd(s.split(':').first) |->Str| { return s.split(':').last }
		}
		if (doc.containsKey("cid") && doc.size < 8)
			return null
		return doc
	}
	
}
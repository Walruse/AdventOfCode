
class Day4_Part2 {
	
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
		
		numValid := 0
		
		documents.each |[Str:Str] doc| {
			if (doc.get("byr").size == 4 && doc.get("byr").toInt >= 1920 && doc.get("byr").toInt <= 2002) {
				if (doc.get("iyr").size == 4 && doc.get("iyr").toInt >= 2010 && doc.get("iyr").toInt <= 2020) {
					if (doc.get("eyr").size == 4 && doc.get("eyr").toInt >= 2020 && doc.get("eyr").toInt <= 2030) {
						hgtValid := false
						if (doc.get("hgt").getRange(-2..-1) == "cm" && doc.get("hgt").getRange(0..-3).toInt >= 150 && doc.get("hgt").getRange(0..-3).toInt <= 193)
							hgtValid = true
						if (doc.get("hgt").getRange(-2..-1) == "in" && doc.get("hgt").getRange(0..-3).toInt >= 59 && doc.get("hgt").getRange(0..-3).toInt <= 76)
							hgtValid = true
						if (hgtValid){
							if (doc.get("hcl").get(0) == '#' && doc.get("hcl").getRange(1..-1).isAlphaNum) {
								if (doc.get("ecl") == "amb" || doc.get("ecl") == "blu" || doc.get("ecl") == "brn" || doc.get("ecl") == "gry" || doc.get("ecl") == "grn" || doc.get("ecl") == "hzl" || doc.get("ecl") == "oth") {
									if (doc.get("pid").size == 9 && doc.get("pid").toInt.typeof == Int#) {
										numValid++
									}
								}
							}
						}
					}
				}
			}
		}
		
//		byr (Birth Year) - four digits; at least 1920 and at most 2002.
//		iyr (Issue Year) - four digits; at least 2010 and at most 2020.
//		eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
//		hgt (Height) - a number followed by either cm or in:
//		If cm, the number must be at least 150 and at most 193.
//		If in, the number must be at least 59 and at most 76.
//		hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
//		ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
//		pid (Passport ID) - a nine-digit number, including leading zeroes.
//		cid (Country ID) - ignored, missing or not.
		
		echo(numValid.toStr)
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
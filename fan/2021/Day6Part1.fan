
class Day6Part1 {
	
	LanternFish[] 	allFish 	:= LanternFish[,]
	Int				dayCount 	:= 0
	
	private Void main() {
		start := DateTime.now(1ns)
		
		input 		:= `inputs/2021/day6.txt`.toFile.readAllStr
		allCounts 	:= input.split(',')
		allFish		 = allCounts.map { LanternFish(it) }
		
		while (this.dayCount < 80) {
			fishToAdd := LanternFish[,]
			for (i := 0; i < allFish.size; i++) {
				newFish := allFish[i].update
				if (newFish != null)
					fishToAdd.add(newFish)
			}
			
			if (fishToAdd.size > 0)
				allFish.addAll(fishToAdd)
			
			echo(dayCount)
			dayCount++
		}
		
		echo(allFish.size)
		echo(DateTime.now(1ns) - start)
	}
	
}

class LanternFish {
	
	Int countdown
	
	new makeNew() {
		this.countdown = 8
	}
	
	new makeFromInput(Str curCountStr) {
		this.countdown = Int(curCountStr)
	}
	
	LanternFish? update() {
		if (this.countdown == 0) {
			this.countdown = 6
			return LanternFish()
		}
		
		this.countdown--
		return null
	}
	
}

class Day6Part2 {
	
	Int						dayCount 	:= 0
	
	private Void main() {
		start := DateTime.now(1ns)
		
		input 		:= `inputs/2021/day6.txt`.toFile.readAllStr
		fishCounts  := Int:Int[:]
		input.split(',').map { LanternFish(it) }.groupBy |LanternFish fish, Int i->Int| { 
			return fish.countdown
		}.each |val, key| { 
			fishCounts[key] = val.size
		}
		
		while (this.dayCount < 256) {
			echo(dayCount)
			echo(fishCounts)
			newCounts := Int:Int[:]
			fishCounts.each |numFish, countdown| { 
				if (countdown == 0) {
					newCounts[6] = (newCounts.getChecked(6, false) ?: 0) + numFish
					newCounts[8] = (newCounts.getChecked(8, false) ?: 0) + numFish
				}
				else 
					newCounts[countdown - 1] = (newCounts.getChecked(countdown - 1, false) ?: 0) + numFish
			}
			
			fishCounts = newCounts
			dayCount++
		}
		count := 0
		fishCounts.each |numFish| { count += numFish }
		echo(count)
		echo(DateTime.now(1ns) - start)
	}
	
}
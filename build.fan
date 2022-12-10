using build

class Build : BuildPod {

	new make() {
		podName = "adventOfCode"
		summary = "My Awesome AdventOfCode Project"
		version = Version("1.0")

		meta = [
			"pod.dis" : "AdventOfCode"
		]

		depends = [
			"sys 1.0"
		]

		srcDirs = [`fan/`, `fan/2020/`, `fan/2021/`, `fan/2022/`]
		resDirs = [,]

		docApi = true
		docSrc = true
	}
}

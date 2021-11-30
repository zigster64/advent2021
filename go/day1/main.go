package main

import (
	"io/ioutil"
	"strconv"
	"strings"
	"time"

	"github.com/steveoc64/memdebug"
)

func main() {
	t1 := time.Now()
	memdebug.Print(t1, "startup")
	data, err := ioutil.ReadFile("input.data")
	if err != nil {
		panic(err)
	}
	lines := strings.Split(string(data), "\n")
	memdebug.Print(t1, "loaded the data")
	part1(lines)
	memdebug.Print(t1, "done pass 1")
	part2(lines)
	memdebug.Print(t1, "done pass 2")
}

func part1(lines []string) {
	var lastDepth uint64
	var increases uint
	for i, line := range lines {
		if len(line) > 0 {
			depth, err := strconv.ParseUint(line, 10, 16)
			if err != nil {
				panic("not a number")
			}
			//print(line)
			if i > 0 && depth > lastDepth {
				increases++
				//print(" +")
			}
			lastDepth = depth
			//println("")
		}
	}
	println("There were", increases, "increases on the first set")
}

func part2(lines []string) {
	var increases uint
	a, _ := strconv.ParseUint(lines[0], 10, 16)
	b, _ := strconv.ParseUint(lines[0], 10, 16)
	c, _ := strconv.ParseUint(lines[0], 10, 16)
	first := a + b + c
	a = b
	b = c
	for i, line := range lines {
		if i > 2 && len(line) > 0 {
			c, err := strconv.ParseUint(line, 10, 16)
			if err != nil {
				panic("not a number")
			}
			//print(line)
			second := a + b + c
			if second > first {
				increases++
				//print(" +")
			}
			first = second
			a = b
			b = c
			//println("")
		}
	}
	println("There were", increases, "increases on the second set")
}

package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	input, err := ioutil.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}

	part1(input)
	part2(input)
}

func part1(input []byte) {
	frequency := 0
	changes := strings.Split(strings.TrimRight(string(input), "\n"), "\n")
	for _, change := range changes {
		iChange, err := strconv.Atoi(change)
		if err != nil {
			panic(err)
		}
		frequency += iChange
	}

	fmt.Println(frequency)
}

func part2(input []byte) {
	frequency := 0
	found := false

	changes := strings.Split(strings.TrimRight(string(input), "\n"), "\n")
	visitedFrequencies := make(map[int]bool)
	visitedFrequencies[frequency] = true

	for {
		if found {
			fmt.Println(frequency)
			break
		}

		for _, change := range changes {
			iChange, err := strconv.Atoi(change)
			if err != nil {
				panic(err)
			}
			frequency += iChange

			if visitedFrequencies[frequency] == true {
				found = true
				break
			} else {
				visitedFrequencies[frequency] = true
			}
		}
	}
}

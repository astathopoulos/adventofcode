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
	fabric := make(map[int]map[int]int)
	maxOverlaps := 0
	ids := strings.Split(strings.TrimRight(string(input), "\n"), "\n")
	for _, id := range ids {
		numberAndInstructions := strings.Split(id, "@")
		_, instructions := numberAndInstructions[0], numberAndInstructions[1]
		paddingsAndSize := strings.Split(instructions, ":")

		paddings := strings.Split(strings.Trim(paddingsAndSize[0], " "), ",")
		sizes := strings.Split(strings.Trim(paddingsAndSize[1], " "), "x")

		paddingLeft, _ := strconv.Atoi(paddings[0])
		paddingTop, _ := strconv.Atoi(paddings[1])

		width, _ := strconv.Atoi(sizes[0])
		height, _ := strconv.Atoi(sizes[1])

		for i := paddingLeft; i < paddingLeft+width; i++ {
			for j := paddingTop; j < paddingTop+height; j++ {
				if fabric[i] == nil {
					fabric[i] = make(map[int]int)
				}

				if fabric[i][j] == 1 {
					maxOverlaps++
				}

				fabric[i][j]++
			}
		}
	}
	fmt.Println(maxOverlaps)
}

func part2(input []byte) {
	fabric := make(map[int]map[int]int)
	fabricMap := make(map[int]map[int]string)
	ids := strings.Split(strings.TrimRight(string(input), "\n"), "\n")
	taintedIds := make(map[string]int)
	for _, id := range ids {
		numberAndInstructions := strings.Split(id, "@")
		_, instructions := numberAndInstructions[0], numberAndInstructions[1]
		paddingsAndSize := strings.Split(instructions, ":")

		paddings := strings.Split(strings.Trim(paddingsAndSize[0], " "), ",")
		sizes := strings.Split(strings.Trim(paddingsAndSize[1], " "), "x")

		paddingLeft, _ := strconv.Atoi(paddings[0])
		paddingTop, _ := strconv.Atoi(paddings[1])

		width, _ := strconv.Atoi(sizes[0])
		height, _ := strconv.Atoi(sizes[1])

		for i := paddingLeft; i < paddingLeft+width; i++ {
			for j := paddingTop; j < paddingTop+height; j++ {
				if fabric[i] == nil {
					fabric[i] = make(map[int]int)
					fabricMap[i] = make(map[int]string)
				}

				if fabric[i][j] >= 1 {
					taintedIds[fabricMap[i][j]] = 1
					taintedIds[id] = 1
				}

				fabric[i][j]++
				fabricMap[i][j] = id
			}
		}
	}

	for _, id := range ids {
		_, ok := taintedIds[id]
		if ok == false {
			fmt.Println(id)
		}
	}
}

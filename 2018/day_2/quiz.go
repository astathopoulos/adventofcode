package main

import (
	"fmt"
	"io/ioutil"
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
	ids := strings.Split(strings.TrimRight(string(input), "\n"), "\n")
	doubles, triples := 0, 0
	for _, id := range ids {
		runes := []rune(id)
		DoublesForID, TriplesForID := false, false
		runeCounts := make(map[rune]int)
		for _, r := range runes {
			runeCounts[r]++
		}
		for _, count := range runeCounts {
			if count == 2 && DoublesForID == false {
				doubles++
				DoublesForID = true
			} else if count == 3 && TriplesForID == false {
				triples++
				TriplesForID = true
			}

			if DoublesForID == true && TriplesForID == true {
				break
			}
		}
	}

	fmt.Println(doubles * triples)
}

func part2(input []byte) {
	ids := strings.Split(strings.TrimRight(string(input), "\n"), "\n")

	for outterIndex, id := range ids {
		for innerIndex := outterIndex + 1; innerIndex < len(ids); innerIndex++ {
			candidate := ids[innerIndex]

			if outterIndex == innerIndex {
				continue
			}

			idRunes := []rune(id)
			candidateRunes := []rune(candidate)
			matches := 0
			matchedRunes := make([]rune, len(idRunes))

			for index, idRune := range idRunes {
				if idRune == candidateRunes[index] {
					matches++
					matchedRunes = append(matchedRunes, idRune)
				}
			}

			if matches == len(idRunes)-1 {
				fmt.Println(string(matchedRunes))
			}
		}
	}
}

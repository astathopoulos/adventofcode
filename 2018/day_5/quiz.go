package main

import (
	"fmt"
	"io/ioutil"
	"strings"
	"unicode"
)

func main() {
	input, err := ioutil.ReadFile("input.txt")
	// input, err := ioutil.ReadFile("input_sample.txt")
	if err != nil {
		panic(err)
	}

	polymer := strings.Split(strings.TrimRight(string(input), "\n"), "\n")[0]
	part1(polymer)
	part2(polymer)

}

func react(units []rune) int {
	var previousUnit rune

	modified := false

	for {
		for index, unit := range units {
			if index == 0 {
				previousUnit = unit
				continue
			}

			if previousUnit != unit && unicode.To(unicode.UpperCase, previousUnit) == unicode.To(unicode.UpperCase, unit) {
				units = append(units[:(index-1)], units[(index+1):]...)
				modified = true
				break
			} else {
				previousUnit = unit
			}
		}
		if modified == false {
			break
		} else {
			modified = false
		}
	}
	return len(units)
}

func part1(polymer string) {
	units := []rune(polymer)
	fmt.Println(react(units))
}

func part2(polymer string) {
	units := []rune(polymer)

	uniqueUnits := make(map[rune]int)
	finalSizePerUnit := make(map[rune]int)
	for _, unit := range units {
		uniqueUnits[unicode.To(unicode.UpperCase, unit)]++
	}

	for unitLetter := range uniqueUnits {
		newPolymer := strings.Replace(polymer, string(unitLetter), "", -1)
		newPolymer = strings.Replace(newPolymer, string(unicode.To(unicode.LowerCase, unitLetter)), "", -1)

		units := []rune(newPolymer)
		finalSizePerUnit[unitLetter] = react(units)
	}

	var finalUnit rune
	minSize := 0

	for unit, size := range finalSizePerUnit {
		if minSize == 0 || size <= minSize {
			finalUnit = unit
			minSize = size
		}
	}
	fmt.Println(string(finalUnit), minSize)
}

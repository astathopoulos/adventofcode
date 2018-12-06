package main

import (
	"fmt"
	"io/ioutil"
	"math"
	"regexp"
	"strconv"
	"strings"
)

type Point struct {
	X int
	Y int
}

type Points []Point

func (point Point) Distance(p Point) int {
	distance := math.Abs(float64(point.X-p.X)) + math.Abs(float64(point.Y-p.Y))
	return int(distance)
}

func main() {
	input, err := ioutil.ReadFile("input.txt")
	// input, err := ioutil.ReadFile("input_sample.txt")
	if err != nil {
		panic(err)
	}

	var points Points

	coordinates := strings.Split(strings.TrimRight(string(input), "\n"), "\n")
	xyRe := regexp.MustCompile(`(\d+), (\d+)`)
	for _, coordinate := range coordinates {
		match := xyRe.FindStringSubmatch(coordinate)
		x, _ := strconv.Atoi(match[1])
		y, _ := strconv.Atoi(match[2])
		point := Point{x, y}
		points = append(points, point)
	}

	var maxX, maxY int
	for index, point := range points {
		if index == 0 {
			maxX = point.X
			maxY = point.Y
			continue
		}

		if maxX < point.X {
			maxX = point.X
		}

		if maxY < point.Y {
			maxY = point.Y
		}
	}

	minsPerPoint := make(map[Point]int)
	edge := make(map[Point]bool)
	maxSum := 10000
	regions := 0
	for x := 0; x < maxX; x++ {
		for y := 0; y < maxY; y++ {
			min := -1
			nearestPoint := Point{0, 0}
			totalDistance := 0

			for _, point := range points {
				dist := point.Distance(Point{x, y})
				totalDistance += dist

				if dist < min || min == -1 {
					min = dist
					nearestPoint = point
				} else if dist == min {
					nearestPoint = Point{-1, -1}
				}

			}

			if x == 0 || y == 0 {
				edge[nearestPoint] = true
			}

			minsPerPoint[nearestPoint]++

			if totalDistance < maxSum {
				regions++
			}
		}
	}

	max := 0
	for point, value := range minsPerPoint {
		if _, found := edge[point]; value > max && !found {
			max = value
		}
	}
	fmt.Println(max, regions)
}

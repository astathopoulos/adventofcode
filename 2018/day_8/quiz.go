package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

// Node node of a license
type Node struct {
	index       int
	endingIndex int
	children    []Node
	metadata    []int
}

func main() {
	input, err := ioutil.ReadFile("input.txt")
	// input, err := ioutil.ReadFile("input_sample.txt")
	if err != nil {
		panic(err)
	}

	licenseString := strings.Split(strings.TrimRight(string(input), "\n"), " ")
	license := make([]int, len(licenseString))
	for index, str := range licenseString {
		number, _ := strconv.Atoi(str)
		license[index] = number
	}

	metadataSum := 0
	root := buildNode(0, license, &metadataSum)

	fmt.Println(metadataSum)
	fmt.Println(calcNode(root))
}

func buildNode(i int, license []int, metadataSum *int) Node {
	childrenCount := license[i]
	metadataCount := license[i+1]
	metadataStart := i + 2
	endingIndex := metadataStart + metadataCount - 1

	metadata := make([]int, 0, metadataCount)
	children := make([]Node, 0, len(license))

	if childrenCount > 0 {
		childNode := i + 2
		for j := 0; j < childrenCount; j++ {
			child := buildNode(childNode, license, metadataSum)
			childNode = child.endingIndex + 1

			children = append(children, child)
		}

		for _, child := range children {
			if child.endingIndex > metadataStart {
				metadataStart = child.endingIndex + 1
				endingIndex = metadataStart + metadataCount - 1
			}

		}
	}

	if metadataStart == endingIndex+1 {
		metadata = append(metadata, license[metadataStart])
	} else {
		metadata = append(metadata, license[metadataStart:endingIndex+1]...)
	}

	for _, meta := range metadata {
		*metadataSum += meta
	}
	return Node{i, endingIndex, children, metadata}
}

func calcNode(node Node) int {
	if len(node.metadata) == 0 {
		return 0
	}

	sum := 0
	if len(node.children) == 0 {
		for _, meta := range node.metadata {
			sum += meta
		}
	} else {
		for _, meta := range node.metadata {
			if meta > len(node.children) || meta == 0 {
				continue
			}
			sum += calcNode(node.children[meta-1])
		}
	}

	return sum
}

package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"sort"
	"strings"
)

const delay = 60
const workersNo = 5

type Step struct {
	Instruction rune
	Before      rune
}

type Worker struct {
	Instruction   rune
	RemainingTime int
}

func (s Step) String() string {
	return fmt.Sprintf("{%s: %s}", string(s.Instruction), string(s.Before))
}

type Steps []Step

func main() {
	input, err := ioutil.ReadFile("input.txt")
	// input, err := ioutil.ReadFile("input_sample.txt")
	if err != nil {
		panic(err)
	}

	var steps Steps

	instructions := strings.Split(strings.TrimRight(string(input), "\n"), "\n")
	instructionsRe := regexp.MustCompile(`Step (\w) must be finished before step (\w) can begin\.`)
	for _, instruction := range instructions {
		match := instructionsRe.FindStringSubmatch(instruction)
		inst, before := match[1], match[2]
		steps = append(steps, Step{rune(inst[0]), rune(before[0])})
	}

	part1(steps)
	part2(steps)
}

func part1(steps Steps) {
	stoppersPerInstruction := make(map[rune][]rune)
	uniqueStepsMap := make(map[rune]bool)

	for _, step := range steps {
		stoppersPerInstruction[step.Before] = append(stoppersPerInstruction[step.Before], step.Instruction)
		uniqueStepsMap[step.Instruction] = true
		uniqueStepsMap[step.Before] = true
	}

	uniqueSteps := make([]rune, 0, len(uniqueStepsMap))

	for step := range uniqueStepsMap {
		uniqueSteps = append(uniqueSteps, step)
	}

	finalSteps := make([]rune, 0, len(uniqueSteps))
	remainingSteps := make([]rune, len(uniqueSteps), cap(uniqueSteps))

	copy(remainingSteps, uniqueSteps)

	for {
		if len(remainingSteps) == 0 {
			break
		}

		candidateSteps := make([]rune, 0, len(remainingSteps))

		for _, step := range remainingSteps {
			if len(stoppersPerInstruction[step]) == 0 {
				candidateSteps = append(candidateSteps, step)
			}
		}

		sort.Slice(candidateSteps, func(i, j int) bool { return candidateSteps[i] < candidateSteps[j] })

		stepToAdd := candidateSteps[0]
		finalSteps = append(finalSteps, stepToAdd)
		remainingSteps = clearSteps(remainingSteps, stepToAdd)

		for step := range stoppersPerInstruction {
			after := clearSteps(stoppersPerInstruction[step], stepToAdd)
			stoppersPerInstruction[step] = after
		}

	}
	fmt.Println(string(finalSteps))
}

func part2(steps Steps) {
	stoppersPerInstruction := make(map[rune][]rune)
	uniqueStepsMap := make(map[rune]bool)

	for _, step := range steps {
		stoppersPerInstruction[step.Before] = append(stoppersPerInstruction[step.Before], step.Instruction)
		uniqueStepsMap[step.Instruction] = true
		uniqueStepsMap[step.Before] = true
	}

	uniqueSteps := make([]rune, 0, len(uniqueStepsMap))

	for step := range uniqueStepsMap {
		uniqueSteps = append(uniqueSteps, step)
	}

	remainingSteps := make([]rune, len(uniqueSteps), cap(uniqueSteps))

	copy(remainingSteps, uniqueSteps)

	second := 0
	workers := make([]Worker, workersNo)
	idleWorker := Worker{' ', -1}
	finalSteps := make([]rune, 0, len(uniqueSteps))
	for i := 0; i < len(workers); i++ {
		workers[i] = idleWorker
	}
	for {
		if len(remainingSteps) == 0 {
			break
		}

		candidateSteps := make([]rune, 0, len(remainingSteps))

		for _, step := range remainingSteps {
			if len(stoppersPerInstruction[step]) == 0 {
				candidateSteps = append(candidateSteps, step)
			}
		}

		sort.Slice(candidateSteps, func(i, j int) bool { return candidateSteps[i] < candidateSteps[j] })

		finishedTasks := make([]rune, 0, len(candidateSteps))
		idleWorkers := make([]Worker, 0, len(workers))
		for {
			if len(idleWorkers) == len(workers) {
				break
			}
			for i := 0; i < workersNo; i++ {
				if workers[i] == idleWorker {
					if len(candidateSteps) > 0 {
						workers[i] = giveTask(candidateSteps[0])
						remainingSteps = clearSteps(remainingSteps, candidateSteps[0])
						candidateSteps = clearSteps(candidateSteps, candidateSteps[0])
					}
				}

				if workers[i] != idleWorker && !finished(workers[i]) {
					workers[i] = tick(workers[i])
				}

				if finished(workers[i]) {
					finishedTask, worker := finishTask(workers[i])
					workers[i] = worker
					finishedTasks = append(finishedTasks, finishedTask)
				}

			}

			idleWorkers = make([]Worker, 0, len(workers))
			for _, worker := range workers {
				if worker == idleWorker {
					idleWorkers = append(idleWorkers, worker)
				}
			}

			for _, finishedTask := range finishedTasks {
				finalSteps = append(finalSteps, finishedTask)
				removeStep(stoppersPerInstruction, finishedTask)
			}

			second++

			if len(finishedTasks) > 0 {
				break
			}

		}
	}
	fmt.Println(string(finalSteps))
	fmt.Println(second)
}

func clearSteps(steps []rune, removingStep rune) []rune {
	newSteps := make([]rune, 0, len(steps))

	for _, step := range steps {
		if step == removingStep {
			continue
		}
		newSteps = append(newSteps, step)
	}
	return newSteps
}

func timeForStep(step rune) int {
	return int(step-'A') + 1 + delay
}

func tick(w Worker) Worker {
	return Worker{w.Instruction, (w.RemainingTime - 1)}
}

func giveTask(task rune) Worker {
	return Worker{task, timeForStep(task)}
}

func finished(w Worker) bool {
	if w.RemainingTime == 0 {
		return true
	}

	return false
}

func finishTask(w Worker) (rune, Worker) {
	task := w.Instruction
	idleWorker := Worker{' ', -1}

	return task, idleWorker
}

func availableWorker(workers []Worker) int {
	idleWorker := Worker{' ', -1}
	for index, worker := range workers {
		if worker == idleWorker {
			return index
		}
	}
	return -1
}

func removeStep(stoppersPerInstruction map[rune][]rune, finishedStep rune) {
	for step := range stoppersPerInstruction {
		after := clearSteps(stoppersPerInstruction[step], finishedStep)
		stoppersPerInstruction[step] = after
	}
}

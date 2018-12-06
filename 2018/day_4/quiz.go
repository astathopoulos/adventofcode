package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"sort"
	"strconv"
	"strings"
	"time"
)

type Log struct {
	timestamp time.Time
	action    string
}

type Guard struct {
	id             string
	totalSleeptime float64
	sleepMinutes   map[int]int
}

type Guards []Guard

type Logbook []Log

func main() {
	input, err := ioutil.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}

	layout := "2006-01-02 15:04"
	logs := strings.Split(strings.TrimRight(string(input), "\n"), "\n")

	var logbook Logbook

	logRe := regexp.MustCompile(`\[(?P<timestamp>\d{4}-\d{2}-\d{2} \d{2}:\d{2})\] (?P<command>Guard #\d+ begins shift|\w+\s\w+)`)
	for _, logline := range logs {
		match := logRe.FindStringSubmatch(logline)
		timestamp, _ := time.Parse(layout, match[1])
		action := match[2]
		log := Log{timestamp, action}
		logbook = append(logbook, log)
	}

	sort.Slice(logbook, func(i, j int) bool {
		return logbook[i].timestamp.Before(logbook[j].timestamp)
	})

	var guardId string
	var fallsAsleep time.Time
	sleepMinutes := make(map[string]map[int]int)
	totalSleepTimes := make(map[string]float64)

	shiftRe := regexp.MustCompile(`Guard #(\d+) begins shift`)
	actionRe := regexp.MustCompile(`\w+\s\w+`)
	for _, logline := range logbook {
		if match := shiftRe.FindStringSubmatch(logline.action); len(match) != 0 {
			guardId = match[1]
		} else if match := actionRe.FindStringSubmatch(logline.action); len(match) != 0 {
			if logline.action == "falls asleep" {
				fallsAsleep = logline.timestamp
			} else if logline.action == "wakes up" {
				wakesUpMinute := logline.timestamp.Minute()
				totalSleepTimes[guardId] += logline.timestamp.Sub(fallsAsleep).Minutes()
				for i := fallsAsleep.Minute(); i < wakesUpMinute; i++ {
					if sleepMinutes[guardId] == nil {
						sleepMinutes[guardId] = make(map[int]int)
					}
					sleepMinutes[guardId][i]++
				}
			}
		}
	}

	var guards Guards
	for k, v := range totalSleepTimes {
		guards = append(guards, Guard{k, v, sleepMinutes[k]})
	}

	sort.Slice(guards, func(i, j int) bool {
		return guards[i].totalSleeptime > guards[j].totalSleeptime
	})

	guard := guards[0]
	maxcount := 0
	bestMinute := 0
	for minute, count := range guard.sleepMinutes {
		if count >= maxcount {
			maxcount = count
			bestMinute = minute
		}
	}

	intId, _ := strconv.Atoi(guard.id)
	fmt.Println(bestMinute * intId)

	maxcount = 0
	bestMinute = 0
	var guardMoreAsleep Guard
	for _, guard := range guards {
		for minute, count := range guard.sleepMinutes {
			if count >= maxcount {
				guardMoreAsleep = guard
				maxcount = count
				bestMinute = minute
			}
		}
	}

	intId, _ = strconv.Atoi(guardMoreAsleep.id)
	fmt.Println(bestMinute * intId)
}

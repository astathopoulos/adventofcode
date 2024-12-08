"""
According to the protocol, if the patrol cannot move forward,
it should turn right 90 degrees. So, the ordering of the chars is important,
since the patrol will continue to the next direction in the current position
chars array if it cannot move forward.
"""
CURRENT_POSITION_CHARS = ['^', '>', 'v', '<']
OBSTACLE_CHAR = '#'
NEXT_POSITION = {
  '^': (-1, 0),
  '>': (0, 1),
  'v': (1, 0),
  '<': (0, -1)
}

def read_input(filename):
  try:
    with open(filename, 'r') as file:
      return file.readlines()
  except FileNotFoundError:
    print(f'File {filename} not found')
  except Exception as e:
    print(f'An error occurred: {e}')

def current_state(array_of_chars):
  for i in range(len(array_of_chars)):
    for j in range(len(array_of_chars[i])):
      if array_of_chars[i][j] in CURRENT_POSITION_CHARS:
        return (array_of_chars[i][j], (i, j))

  return (None, None)

def out_of_bounds(array_of_chars, position):
  return (position[0] < 0 or
          position[0] >= len(array_of_chars) or
          position[1] < 0 or
          position[1] >= len(array_of_chars[0]))

def next_direction(current_direction):
  return CURRENT_POSITION_CHARS[(CURRENT_POSITION_CHARS.index(current_direction) + 1) % len(CURRENT_POSITION_CHARS)]

if __name__ == '__main__':
  input_data = read_input('input.txt')
  array_of_chars = [list(line.strip()) for line in input_data]
  current_direction, current_position = current_state(array_of_chars)
  next_position = current_position
  past_positions = set()
  past_positions.add(current_position)

  while True:
    next_position = (current_position[0] + NEXT_POSITION[current_direction][0],
                     current_position[1] + NEXT_POSITION[current_direction][1])

    if out_of_bounds(array_of_chars, next_position):
      break

    if array_of_chars[next_position[0]][next_position[1]] == OBSTACLE_CHAR:
      current_direction = next_direction(current_direction)
      continue

    past_positions.add(next_position)
    current_position = next_position

  print(len(past_positions))

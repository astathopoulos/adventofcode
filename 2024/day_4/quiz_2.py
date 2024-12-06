MAS_CHARS = ['M', 'A', 'S']

def read_input(filename):
  try:
    with open(filename, 'r') as file:
      return file.readlines()
  except FileNotFoundError:
    print(f'File {filename} not found')
  except Exception as e:
    print(f'An error occurred: {e}')

def search_for_mas(i, j, array_of_chars, direction_combos):
  found = False
  for x in range(len(direction_combos)):
    char_index = 0
    should_break = False
    for x_direction, y_direction in direction_combos[x]:
      if array_of_chars[i + x_direction][j + y_direction] == MAS_CHARS[char_index]:
        char_index += 2
        found = True
      else:
        found = False
        should_break = True
        break
    if should_break:
      break

  return found

def search_for_xmas(i, j, array_of_chars):
  possible_directions = [
    [
      [(-1, -1), (1, 1)], # Up left to down right
      [(-1, 1), (1, -1)] # Up right to down left
    ],
    [
      [(1, 1), (-1, -1)], # Down right to up left
      [(1, -1), (-1, 1)] # Down Left το Up Right
    ],
    [
      [(-1, -1), (1, 1)], # Up left to down right
      [(1, -1), (-1, 1)] # Down left to up left
    ],
    [
      [(-1, 1), (1, -1)], # Up left to down right
      [(1, 1), (-1, -1)] # Down right to up left
    ],
    [
      [(1, 1), (-1, -1)], # Down right to up left
      [(-1, 1), (1, -1)]# Up left to down right
    ],
    [
      [(1, -1), (-1, 1)], # Down right to up left
      [(-1, 1), (1, -1)] # Up right to down left
    ],
    [
      [(1, 1), (-1, -1)], # Down right to up left
      [(1, -1), (-1, 1)] # Down Left το Up Right
    ]
  ]

  for direction_combos in possible_directions:
    procced = True
    for direction_pair in direction_combos:
      for direction in direction_pair:
        if (i + direction[0] >= len(array_of_chars) or
            j + direction[1] >= len(array_of_chars[i + direction[0]]) or
            i + direction[0] < 0 or
            j + direction[1] < 0):
          procced = False

    if procced:
      xmas_found = search_for_mas(i, j, array_of_chars, direction_combos)
      if xmas_found:
        return True

  return False

if __name__ == '__main__':
  input_data = read_input('input.txt')
  array_of_chars = [list(line.strip()) for line in input_data]

  total_xmas = 0
  for i in range(len(array_of_chars)):
    for j in range(len(array_of_chars[i])):
      if array_of_chars[i][j] == MAS_CHARS[1]:
        found = search_for_xmas(i, j, array_of_chars)
        if found:
          total_xmas += 1

  print(f'Total X-MAS found: {total_xmas}')

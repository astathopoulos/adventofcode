XMAS_CHARS = ['X', 'M', 'A', 'S']

def read_input(filename):
  try:
    with open(filename, 'r') as file:
      return file.readlines()
  except FileNotFoundError:
    print(f'File {filename} not found')
  except Exception as e:
    print(f'An error occurred: {e}')

def search_for_xmas(i, j, array_of_chars, direction):
  i_direction, j_direction = direction

  for char in XMAS_CHARS[1:]:
    if(i + i_direction < len(array_of_chars) and
       j + j_direction < len(array_of_chars[i + i_direction]) and
       array_of_chars[i + i_direction][j + j_direction] == char):
      i += i_direction
      j += j_direction
    else:
      return 0

  return 1

  print('XMAS found')
def search_search_for_xmas(i, j, array_of_chars):
  xmas_count = 0

  possible_directions = [
    (1, 0), # Down
    (0, 1), # Right
    (1, 1), # Down Right
    (1, -1), # Down Left
    (-1, 1), # Up Right
    (-1, -1), # Up Left
    (-1, 0), # Up
    (0, -1) # Left
  ]

  final_directions = possible_directions.copy()

  remaining_chars = len(XMAS_CHARS) - 1
  # let's rule out impossible directions based on the current position
  for direction in possible_directions:
    if (i + (direction[0] * remaining_chars) >= len(array_of_chars) or
        j + (direction[1] * remaining_chars) >= len(array_of_chars[i + direction[0]]) or
        i + (direction[0] * remaining_chars) < 0 or
        j + (direction[1] * remaining_chars) < 0):
      final_directions.remove(direction)

  for direction in final_directions:
    xmas_count += search_for_xmas(i, j, array_of_chars, direction)

  return xmas_count

  print('XMAS found')
if __name__ == '__main__':
  input_data = read_input('input.txt')
  array_of_chars = [list(line.strip()) for line in input_data]

  total_xmas = 0
  for i in range(len(array_of_chars)):
    for j in range(len(array_of_chars[i])):
      if array_of_chars[i][j] == XMAS_CHARS[0]:
        total_xmas += search_search_for_xmas(i, j, array_of_chars)

  print(f'Total XMAS found: {total_xmas}')

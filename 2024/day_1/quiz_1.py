def read_input(filename):
  try:
    with open(filename, 'r') as file:
      return file.readlines()
  except FileNotFoundError:
    print(f'File {filename} not found')
  except Exception as e:
    print(f'An error occurred: {e}')

if __name__ == '__main__':
  input_data = read_input('input.txt')
  left_list = []
  right_list = []
  for line in input_data:
    left, right = map(int, line.strip().split())
    left_list.append(left)
    right_list.append(right)

  left_list.sort()
  right_list.sort()
  diff_array = [abs(a -b) for a, b in zip(left_list, right_list)]

  sum_diff = sum(diff_array)
  print(sum_diff)

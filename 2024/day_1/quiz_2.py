from collections import Counter

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

  occurrencies = Counter(right_list)
  sum_counts = sum(num * occurrencies[num] for num in left_list)
  print(sum_counts)

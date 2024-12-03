import re

def read_input(filename):
  try:
    with open(filename, 'r') as file:
      return file.read()
  except FileNotFoundError:
    print(f'File {filename} not found')
  except Exception as e:
    print(f'An error occurred: {e}')

if __name__ == '__main__':
  input_data = read_input('input.txt')
  line = input_data.strip()

  mul_pattern = r'mul\(\d{1,3},\d{1,3}\)'
  matches = re.findall(mul_pattern, line)

  print(matches)
  number_pattern = r'\d{1,3}'
  multipliers = [re.findall(number_pattern, match) for match in matches]
  print(multipliers)
  total_sum = 0
  for a, b in multipliers:
    total_sum += int(a) * int(b)

  print(total_sum)

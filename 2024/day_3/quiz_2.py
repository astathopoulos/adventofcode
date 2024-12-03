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

  do_pattern = r'do\(\)'
  dont_pattern = r'don\'t\(\)'
  mul_pattern = r'mul\(\d{1,3},\d{1,3}\)'
  number_pattern = r'\d{1,3}'
  do_parts = re.split(do_pattern, line)
  multiply_parts = []
  for part in do_parts:
    multiply_parts.append(re.split(dont_pattern, part)[0])

  total_sum = 0

  for part in multiply_parts:
    matches = re.findall(mul_pattern, part)
    multipliers = [re.findall(number_pattern, match) for match in matches]
    for a, b in multipliers:
      total_sum += int(a) * int(b)

  print(total_sum)

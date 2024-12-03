def read_input(filename):
  try:
    with open(filename, 'r') as file:
      return file.readlines()
  except FileNotFoundError:
    print(f'File {filename} not found')
  except Exception as e:
    print(f'An error occurred: {e}')

def find_direction(report):
  """
  Returns the direction of the report based on the direction that most
  elements are moving towards.
  """
  up = 0
  down = 0

  for i in range(len(report) - 1):
    if report[i] < report[i+1]:
      up += 1
    elif report[i] > report[i+1]:
      down += 1

  return 'asc' if up > down else 'desc'

def have_correct_direction(a, b, direction):
  if direction == 'asc':
    return a < b
  return a > b

def is_safe(report):
  direction = find_direction(report)

  safe = False

  for i in range(len(report) - 1):
    if have_correct_direction(report[i], report[i+1], direction):
      if abs(report[i] - report[i+1]) >= 1 and abs(report[i] - report[i+1]) <= 3:
        safe = True
      else:
        safe = False
        break
    else:
      safe = False
      break

  return safe


if __name__ == '__main__':
  input_data = read_input('input.txt')
  reports = []
  for line in input_data:
    reports.append(list(map(int, line.strip().split())))

  safe_reports_count = [is_safe(report) for report in reports].count(True)
  print(safe_reports_count)

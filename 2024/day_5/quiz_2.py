def read_input(filename):
  try:
    with open(filename, 'r') as file:
      return file.readlines()
  except FileNotFoundError:
    print(f'File {filename} not found')
  except Exception as e:
    print(f'An error occurred: {e}')

def swap(arr, i, j):
  arr[i], arr[j] = arr[j], arr[i]

def update_correction(update, ordering_rules_dict):
  page_array = [int(page) for page in update.split(',')]
  altered = False
  valid = None

  while not valid:
    valid = None

    for i, page in enumerate(page_array):
      pages_before = page_array[:i]
      pages_after = page_array[i + 1:]

      for before in pages_before:
        if before in ordering_rules_dict.get(page, {}).get('before', []):
          valid = False
          # swap the pages
          altered = True
          before_index = page_array.index(before)
          swap(page_array, i, before_index)

      for after in pages_after:
        if after in ordering_rules_dict.get(page, {}).get('after', []):
          valid = False
          altered = True
          # swap the pages
          after_index = page_array.index(after)
          swap(page_array, i, after_index)

    if valid is None:
      valid = True

  if altered:
    return ','.join(map(str, page_array))
  else:
    return None

def get_middle(arr):
    if len(arr) % 2 == 0:
        return arr[(len(arr) - 1) // 2 : len(arr) // 2 + 1]
    return arr[len(arr) // 2]

if __name__ == '__main__':
  input_data = read_input('input.txt')
  ordering_rules = []
  updates = []

  for line in input_data:
    if line.strip() == '':
      break
    ordering_rules.append(line.strip())

  ordering_rule_numbers = {int(num) for rule in ordering_rules for num in rule.split('|')}

  ordering_rules_dict = {}
  for number in ordering_rule_numbers:
    for rule in ordering_rules:
      before, after = map(int, rule.split('|'))
      if number == before:
        ordering_rules_dict.setdefault(number, {}).setdefault('before', []).append(after)

      if number == after:
        ordering_rules_dict.setdefault(number, {}).setdefault('after', []).append(before)


  updates = [line.strip() for line in input_data[len(ordering_rules) + 1:]]

  invalid_updates = [corrected_update for update in updates if (corrected_update := update_correction(update, ordering_rules_dict)) is not None]
  sum_of_middle_pages = sum([get_middle([int(page) for page in update.split(',')]) for update in invalid_updates])

  print(f'Sum of middle pages: {sum_of_middle_pages}')

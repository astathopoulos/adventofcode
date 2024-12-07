def read_input(filename):
  try:
    with open(filename, 'r') as file:
      return file.readlines()
  except FileNotFoundError:
    print(f'File {filename} not found')
  except Exception as e:
    print(f'An error occurred: {e}')

def is_valid_update(update, ordering_rules_dict):
  page_array = [int(page) for page in update.split(',')]
  valid = True
  for i in range(len(page_array)):
    page = page_array[i]
    pages_before = page_array[:i]
    pages_after = page_array[i + 1:]

    for before in pages_before:
      if before in ordering_rules_dict.get(page, {}).get('before', []):
        print(f'Invalid update: {update} - {before} is before {page}')
        valid = False
        break

    for after in pages_after:
      if after in ordering_rules_dict.get(page, {}).get('after', []):
        print(f'Invalid update: {update} - {after} is after {page}')
        valid = False
        break

  return valid


def get_middle(arr):
    if len(arr) % 2 == 0:
        return arr[(len(arr) - 1) // 2 : len(arr) // 2 + 1]
    return arr[len(arr) // 2]

if __name__ == '__main__':
  input_data = read_input('input_sample.txt')
  ordering_rules = []
  updates = []

  for line in input_data:
    if line.strip() == '':
      break
    ordering_rules.append(line.strip())

  ordering_rule_numbers = {int(num) for rule in ordering_rules for num in rule.split('|')}
  print(f'Ordering rule numbers: {ordering_rule_numbers}')

  ordering_rules_dict = {}
  for number in ordering_rule_numbers:
    for rule in ordering_rules:
      before, after = map(int, rule.split('|'))
      if number == before:
        ordering_rules_dict.setdefault(number, {}).setdefault('before', []).append(after)

      if number == after:
        ordering_rules_dict.setdefault(number, {}).setdefault('after', []).append(before)

  print(f'Ordering rules dict: {ordering_rules_dict}')

  updates = [line.strip() for line in input_data[len(ordering_rules) + 1:]]

  print(f'Ordering rules: {ordering_rules}')
  print(f'Updates: {updates}')

  valid_updates = [update for update in updates if is_valid_update(update, ordering_rules_dict)]
  print(f'Valid updates: {valid_updates}')

  sum_of_middle_pages = sum([get_middle([int(page) for page in update.split(',')]) for update in valid_updates])
  print(f'Sum of middle pages: {sum_of_middle_pages}')

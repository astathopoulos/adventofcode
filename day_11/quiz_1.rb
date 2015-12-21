current_password = 'hxbxwxba'

def two_pairs?(password)
  password.chars.each_cons(2).map { |pairs|
    pairs[0] == pairs[1] ? [pairs] : nil
  }.compact.uniq.size >= 2
end

def increasing?(password)
  password.chars.each_cons(3).map { |triple|
    triple[2] == triple[1].next && triple[1] == triple[0].next
  }.include?(true)
end

def valid?(password)
  !password.match(/[iol]/) && two_pairs?(password) && increasing?(password)
end

loop do
  current_password = current_password.next

  break if valid?(current_password)
end

p current_password

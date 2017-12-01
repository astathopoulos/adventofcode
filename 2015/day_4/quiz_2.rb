require 'digest'
message = 'yzbqklnj'

i = 1
while !Digest::MD5.hexdigest(message + i.to_s).start_with?('000000')
  i +=1
end

puts i

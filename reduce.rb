#!/usr/bin/ruby1.9.1

prev_key=nil
init_val = 1

STDIN.each do |line|
key, value = line.split("\t")
if prev_key != nil && prev_key != key
puts prev_key + "\t" + init_val.to_s
prev_key = key
init_val = 1
elsif prev_key == nil
prev_key = key
elsif prev_key == key
init_val = init_val + value.to_i
end
end

puts prev_key + "\t" + init_val.to_s
#!/usr/bin/env ruby

key = nil
STDIN.each do |line|
  value = nil
  line.split(',').each_with_index do |word,index|
    if index==0 
      key = word 
    else
      value == nil ? value = word : value = value + "," + word
    end     
  end
  puts key + "\t" + value 
end

#!/usr/bin/env ruby

NUMBER_OF_ENTRIES = 2

#command = ARGV[0]

require 'yaml'
data = YAML.load_file('./list.yml')


day_of_year = Date.today.yday
categories = data.keys

category_offsets = categories.map do |cat|
  [cat, day_of_year % data[cat].count]
end.to_h


output = categories.map do |cat|
  offset = category_offsets[cat]
  [cat, data[cat][offset, NUMBER_OF_ENTRIES]]
end

puts output.inspect

#category_offsets.

#puts category_offsets[]

#quote_offset = 
#reminder = day_of_year % data['quotes'].count

#puts data['quotes'].sample(2)

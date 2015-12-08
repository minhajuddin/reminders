#!/usr/bin/env ruby

require 'bundler/setup'

NUMBER_OF_ENTRIES = 2
RECIPIENT = 'minhajuddin.k@gmail.com'

#command = ARGV[0]

require 'yaml'
require 'erb'
require 'pony'

data = YAML.load_file('./list.yml')
tmpl = ERB.new(File.read('./template.erb'))

day_of_year = Date.today.yday
categories = data.keys

category_offsets = categories.map do |cat|
  [cat, day_of_year % data[cat].count]
end.to_h


output = categories.map do |cat|
  offset = category_offsets[cat]
  [cat, data[cat][offset, NUMBER_OF_ENTRIES]]
end

email_body = tmpl.result(binding)

Pony.mail({
  :to => RECIPIENT,
  :via => :sendmail,
  :from => "reminder@zammu.in",
  :subject => "Reminders for #{Date.today}",
  :body => email_body
})

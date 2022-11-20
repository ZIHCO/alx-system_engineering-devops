#!/usr/bin/env ruby
puts ARGV[0].scan(/\[from:([A-Za-z]+|\+?[\d]+)\]/).join+","+ARGV[0].scan(/\[to:(\+?[\d]+)\]/).join+","+ARGV[0].scan(/\[flags:(\-?[\d]{1}:\-?[\d]{1}:\-?[\d]{1}:\-?[\d]{1}:\-?[\d]{1})\]/).join

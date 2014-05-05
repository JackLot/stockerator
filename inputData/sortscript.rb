#!/usr/bin/env ruby
 
puts STDIN.read.split("\n").sort { |a,b| a.rpartition(",").last <=> b.rpartition(",").last }
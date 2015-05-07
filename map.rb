#!/usr/bin/env ruby

require 'csv'
require 'gnuplot'

# load csv and find data from it
drugs = []
accidents_due_to_drugs = []
CSV.foreach("state.csv") do |row|
  drugs.push(row[1].to_i)
  accidents_due_to_drugs.push(row[2].to_i)
end
puts "Drugs"
puts drugs
puts "No of road accidents"
puts accidents_due_to_drugs

# scatter plot for graph
outFname='drugs_vs_accidents.png'
Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
  	plot.output outFname
		plot.terminal 'png'
    plot.title  "Array Plot Example"
    plot.xlabel "Drug"
    plot.ylabel "No of road accident"    

    plot.data << Gnuplot::DataSet.new( [drugs, accidents_due_to_drugs] ) do |ds|
    ds.notitle
    end
  end
end

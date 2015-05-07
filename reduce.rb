#!/usr/bin/env ruby

require 'gnuplot'

# load csv and find data from it
drugs = []
accidents_due_to_drugs = []
STDIN.each do |line|
	key, value = line.split("\t")	
	value.split(',').each_with_index do |word,index|
  	drugs.push(word.to_i) if index == 0
  	accidents_due_to_drugs.push(word.to_i) if index==1
  end
end

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

center_x = [drugs[0],drugs[1],drugs[2]]
center_y = [accidents_due_to_drugs[0],accidents_due_to_drugs[1],accidents_due_to_drugs[2]]

cluster1_x = [drugs[0]]
cluster2_x = [drugs[1]]
cluster3_x = [drugs[2]]
cluster1_y = [accidents_due_to_drugs[0]]
cluster2_y = [accidents_due_to_drugs[1]]
cluster3_y = [accidents_due_to_drugs[2]]

drugs.each_with_index do |drug,key|
  
  distance_from_center1 = (center_x[0]-drug)*(center_x[0]-drug) + (center_y[0]-accidents_due_to_drugs[key])*(center_y[0]-accidents_due_to_drugs[key])
  distance_from_center2 = (center_x[1]-drug)*(center_x[1]-drug) + (center_y[1]-accidents_due_to_drugs[key])*(center_y[1]-accidents_due_to_drugs[key])
  distance_from_center3 = (center_x[2]-drug)*(center_x[2]-drug) + (center_y[2]-accidents_due_to_drugs[key])*(center_y[2]-accidents_due_to_drugs[key])

  min_distance = distance_from_center1
  min_distance = distance_from_center2 if min_distance >= distance_from_center2    
  min_distance = distance_from_center3 if min_distance >= distance_from_center3
    
  next if min_distance == 0

  if min_distance == distance_from_center1
    puts key
    puts "min distance is from cluster1"
    cluster1_x.push(drug) 
    cluster1_y.push(accidents_due_to_drugs[key]) 
  end
  if min_distance == distance_from_center2
    puts key
    puts "min distance is from cluster2"
    cluster2_x.push(drug) 
    cluster2_y.push(accidents_due_to_drugs[key]) 
  end
  if min_distance == distance_from_center3
    puts key
    puts "min distance is from cluster3"
    cluster3_x.push(drug) 
    cluster3_y.push(accidents_due_to_drugs[key]) 
  end
end


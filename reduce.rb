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
new_center_x = []
new_center_y = []

until (center_x == new_center_x && center_y == new_center_y)

	if new_center_x != [] && new_center_y != []
		center_x = new_center_x
		center_y = new_center_y
	end
	cluster1_x = [center_x[0]]
	cluster2_x = [center_x[1]]
	cluster3_x = [center_x[2]]
	cluster1_y = [center_y[0]]
	cluster2_y = [center_y[1]]
	cluster3_y = [center_y[2]]

	drugs.each_with_index do |drug,key|
	  
	  distance_from_center1 = (center_x[0]-drug)*(center_x[0]-drug) + (center_y[0]-accidents_due_to_drugs[key])*(center_y[0]-accidents_due_to_drugs[key])
	  distance_from_center2 = (center_x[1]-drug)*(center_x[1]-drug) + (center_y[1]-accidents_due_to_drugs[key])*(center_y[1]-accidents_due_to_drugs[key])
	  distance_from_center3 = (center_x[2]-drug)*(center_x[2]-drug) + (center_y[2]-accidents_due_to_drugs[key])*(center_y[2]-accidents_due_to_drugs[key])

	  min_distance = distance_from_center1
	  min_distance = distance_from_center2 if min_distance >= distance_from_center2    
	  min_distance = distance_from_center3 if min_distance >= distance_from_center3
	    
	  next if min_distance == 0

	  if min_distance == distance_from_center1	   
	    cluster1_x.push(drug) 
	    cluster1_y.push(accidents_due_to_drugs[key]) 
	  end
	  if min_distance == distance_from_center2	    
	    cluster2_x.push(drug) 
	    cluster2_y.push(accidents_due_to_drugs[key]) 
	  end
	  if min_distance == distance_from_center3	    
	    cluster3_x.push(drug) 
	    cluster3_y.push(accidents_due_to_drugs[key]) 
	  end
	end
	sum = 0
	cluster1_x.each { |a| sum+=a }
	new_center_x[0]=sum/cluster1_x.length
	sum = 0
	cluster2_x.each { |a| sum+=a }
	new_center_x[1]=sum/cluster2_x.length
	sum = 0
	cluster3_x.each { |a| sum+=a }
	new_center_x[2]=sum/cluster3_x.length
	sum = 0
	cluster1_y.each { |a| sum+=a }
	new_center_y[0]=sum/cluster1_y.length
	sum = 0
	cluster2_y.each { |a| sum+=a }
	new_center_y[1]=sum/cluster2_y.length
	sum = 0
	cluster3_y.each { |a| sum+=a }
	new_center_y[2]=sum/cluster3_y.length
end

puts "Data points in cluster1"
cluster1_x.each_with_index do |x,index|
	puts x.to_s + "\t"  + cluster1_y[index].to_s
end

Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
  	plot.output '/home/janvi/tmp/cluster1.png'
		plot.terminal 'png'
    plot.title  "Array Plot Example"
    plot.xlabel "Drug"
    plot.ylabel "No of road accident"    

    plot.data << Gnuplot::DataSet.new( [cluster1_x, cluster1_y] ) do |ds|
    ds.notitle
    end
  end
end

puts "Data points in cluster2"
cluster2_x.each_with_index do |x,index|
	puts x.to_s + "\t"  + cluster2_y[index].to_s
end

Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
  	plot.output '/home/janvi/tmp/cluster2.png'
		plot.terminal 'png'
    plot.title  "Array Plot Example"
    plot.xlabel "Drug"
    plot.ylabel "No of road accident"    

    plot.data << Gnuplot::DataSet.new( [cluster2_x, cluster2_y] ) do |ds| 
    ds.notitle
    end
  end
end

puts "Data points in cluster3"
cluster3_x.each_with_index do |x,index|
	puts x.to_s + "\t"  + cluster3_y[index].to_s
end

Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
  	plot.output '/home/janvi/tmp/cluster3.png'
		plot.terminal 'png'
    plot.title  "Array Plot Example"
    plot.xlabel "Drug"
    plot.ylabel "No of road accident"    

    plot.data << Gnuplot::DataSet.new( [cluster3_x, cluster3_y] ) do |ds| 
    ds.notitle
    end
  end
end




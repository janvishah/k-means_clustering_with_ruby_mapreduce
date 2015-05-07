#!/usr/bin/env ruby
require 'rubygems'
require 'gnuplot'


outFname='graph1.png'
xData=[1, 2, 3, 4, 5, 3.5]
yData=[2, 3 ,4, 2, 3, 2.5]

#xData=(0..10).collect { |v| v.to_f }
#yData= xData.collect { |v| v ** 2 }



Gnuplot.open do |gp|
Gnuplot::Plot.new( gp ) do |plot|
plot.output outFname
plot.terminal 'png'
plot.title "Drugs vs Accident due to drugs"
plot.ylabel "Accidents"
plot.xlabel "Drugs"

x= xData
y= yData

plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|

ds.title
end

end
end

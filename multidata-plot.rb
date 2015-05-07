#!/usr/bin/env ruby
require 'rubygems'
require 'gnuplot'


outFname='graph2.png'

File.open( "gnuplot.dat", "w") do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
    plot.output outFname
    plot.terminal 'png' 
    plot.xrange "[-10:10]"
    plot.title  "Sin Wave Example"
    plot.ylabel "x"
    plot.xlabel "sin(x)"
    
    x = (0..50).collect { |v| v.to_f }
    y = x.collect { |v| v ** 2 }

    plot.data = [
      Gnuplot::DataSet.new( "sin(x)" ) { |ds|
        ds.with = "lines"
        ds.title = "String function"
    	  ds.linewidth = 4
      },
    
      Gnuplot::DataSet.new( [x, y] ) { |ds|
        ds.with = "linespoints"
        ds.title = "Array data"
      }
    ]

  end
end

#!/usr/bin/ruby

require_relative './buildJavaProject.rb'

puts "Running test... dont forget to set $CLASSPATH!"
system "java -cp $CLASSPATH:turborunner.jar brlyman.TurboRunner " + ARGV.first


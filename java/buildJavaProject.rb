#!/usr/bin/ruby

puts "Building project... don't forget to export CLASSPATH!"
puts ""
system 'mkdir -p ./bin'
system 'javac -cp `echo $CLASSPATH`:./bin -d bin `find . -name "*.java"`'


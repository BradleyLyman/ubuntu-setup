#!/usr/bin/ruby

puts "Building project... don't forget to export CLASSPATH!"
puts ""
system 'mkdir -p ./bin'
system 'javac -cp `echo $CLASSPATH`:./bin -d bin `find . -name "*.java"`'

# Copy resource files
resource_output = `find ./src -name '*.resource'`
resources = resource_output.split(' ')
resources.each do |resource|
    system "cp --parents #{resource} bin/"
end


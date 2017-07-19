#!/usr/bin/fish

echo "replace bin dir"
rm -r bin
mkdir bin

echo "remove classes jar"
rm classes.jar

echo "build src"
javac -cp (cat cp) -d bin src/**/*.java

echo "build jar"
jar cvf turborunner.jar -C bin/ .


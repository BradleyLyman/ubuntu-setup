#!/usr/bin/fish

javac -cp (cat cp) -d bin src/**/*.java tst/**/*.java
java -cp (cat cp) com.TurboRunner $argv

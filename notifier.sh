#!/bin/bash

check_process() {
    if [[ $1 ]]; then
        if [[ `ps -A | grep $1` ]]; then
            echo " ---> worker $1 is alive!"
            return 1;
        else
            echo " ---> worker $1 is already dead"
            return 0;
        fi
    else
        echo " ---> worker doesn't exist"
        return 0;
    fi
}

EVENTS="modify,attrib,close_write,move,create,delete"

while true
do
    echo " -> waiting for events in $1"
    inotifywait -r -e $EVENTS $1 2>/dev/null

    echo " -> is the last worker alive?"
    check_process $pid
    if [ $? -eq 1 ]; then
        echo " -> kill worker $pid"
        `kill -9 $pid`
    fi

    echo " -> evaluate notify script"
    eval $2& pid=$!
    echo " -> task started with pid $pid"
done 2>/dev/null

#!/bin/bash

info() {
    # output message with blue text
    echo -e " ->\e[34m $1\e[39m"
}

warn() {
    # output message with yellow text
    echo -e " ->\e[33m Warn: $1\e[39m"
}

error() {
    # output message with magenta text
    echo -e " ->\e[35m Error: $1\e[39m"
}

help() {
    info "Usage: notifier.sh <directory to watch> <command to execute on change>"
    exit
}

WATCH_DIR=$1
CMD=$2

if [[ $WATCH_DIR ]]; then
    info "watching $WATCH_DIR"
else
    error "Please enter a watch directory!"
    help
fi

if [[ $CMD ]]; then
    info "execute $CMD on change"
else
    error "Please enter a command to execute when files change!"
    help
fi

# This method checks if the process with the provided
# PID is alive. It handles the case when PID is empty or not passed
# by returning 0.
is_process_alive() {
    if [[ $1 ]]; then
        if [[ `ps -A | grep $1` ]]; then
            warn "worker $1 is alive!"
            return 1;
        else
            warn "worker $1 is already dead"
            return 0;
        fi
    else
        warn "worker doesn't exist"
        return 0;
    fi
}

kill_process_and_children() {
    pid=$1

    is_process_alive $pid
    if [ $? -eq 1 ]; then
        for i in `ps -ef| awk '$3 == '$pid' { print $2 }'`
        do
            warn "killing $i"
            kill $i
        done
        warn "killing $pid"
        kill $pid
    fi
}

# This is the part where we wait on events and update
EVENTS="modify,attrib,close_write,move,create,delete"

while true
do
    info "waiting for events in $1"
    dir_and_file=`inotifywait -r -e $EVENTS --format "%w%f" $1 2>/dev/null`

    # Get just the file name from the file/directory combo
    file=`echo $dir_and_file | grep -oE '[^/]*$'`

    # Select only file names which include at least a single letter or '.'
    filteredfile=`echo $file | grep -E "[a-zA-Z.]"`
    if [[ $filteredfile ]]; then
        info "file changed: $file"

        kill_process_and_children $pid

        info "evaluate notify script"
        $2 $file& pid=$!
        info "task started with pid $pid"
    else
        # for some reason nvim seems to create temporary files with numbers for names
        # This prevents those temporary files from cluttering up our scripts
        warn "skipping work for file named $file"
    fi


done 2>/dev/null


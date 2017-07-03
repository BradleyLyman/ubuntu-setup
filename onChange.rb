#!/usr/bin/ruby

require './ruby/fs_events.rb'

def help
    info "Usage: onChange <dir> <cmd>"
    info "    <dir> should be the directory to watch"
    info "    <cmd> should be the command to execute on each change"
end

def parse_dir_from(args)
    dir = args.first
    if dir
        dir
    else
        error "Missing <dir> argument"
        nil
    end
end

def validate_dir(dir)
    if !dir
        nil
    elsif File.exists? dir
        dir
    else
        error "File/Directory #{dir} does not exist!"
        nil
    end
end

def parse_cmd_from(args)
    cmd = args[1]
    if cmd
        cmd
    else
        error "Missing <cmd> argument"
        nil
    end
end

def killprocess(pid)
    begin
        Process.kill 9,pid
        true
    rescue Errno::ESRCH
        false
    end
end

# program entrypoint
def main(args)
    dir = validate_dir parse_dir_from args
    cmd = parse_cmd_from args
    if !dir || !cmd
        help
        exit
    end

    info "Setup watch for #{dir}"

    mydir = NonTemporaryEvents
        .with_source UniqueEvents
        .with_source AllDirectoryEvents
        .forDirectory dir

    # TODO clean up process management and remove weird looping construct
    mydir.wait_for_events.each do |event|
        info "%{name} triggered events %{flags}" % {
            name: event.absolute_name,
            flags: event.flags
        }
    end
    pid = Process.spawn cmd

    while true do
        mydir.wait_for_events.each do |event|
            info "%{name} triggered events %{flags}" % {
                name: event.absolute_name,
                flags: event.flags
            }
        end
        killprocess pid
        pid = Process.spawn cmd
    end
end

# start program
main(ARGV)

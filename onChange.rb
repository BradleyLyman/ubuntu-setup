#!/usr/bin/ruby

require './ruby/fs_events.rb'

class RestartableEventProcess
    def self.with_cmd(cmd)
        RestartableEventProcess.new cmd
    end

    def initialize(cmd)
        @cmd = cmd
        @started = false
        @pid = 0
    end

    def restart(event)
        if @started
            killProcess
        end
        @pid = Process.spawn "#{@cmd} #{event.absolute_name}"
        Process.detach @pid
        @started = true
        info "Started process #{@pid}"
    end

    private

    def killProcess
        warn "Killing process #{@pid}"
        begin
            Process.kill 9, @pid
        rescue Errno::ESRCH
            warn "Process already dead"
        end
    end
end

# program entrypoint
def main(dir, cmd)
    info "Setup '#{cmd}' to execute on changes to '#{dir}'"

    event_handler = RestartableEventProcess.with_cmd cmd

    directory_events = NonTemporaryEvents
        .with_source UniqueEvents
        .with_source AllDirectoryEvents
        .forDirectory dir

    while true do
        events = directory_events.wait_for_events
        events.each do |event|
            info "%{name} triggered events %{flags}" % {
                name: event.absolute_name,
                flags: event.flags
            }
        end
        event_handler.restart events.last
    end
end

# start program
begin
    main(ARGV[0], ARGV[1])
rescue => err
    error err
    # Print help
    info "Usage: onChange <dir> <cmd>"
    info "    <dir> should be the directory to watch"
    info "    <cmd> should be the command to execute on each change"
end

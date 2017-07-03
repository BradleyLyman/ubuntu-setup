#!/usr/bin/ruby

require './ruby/fs_events.rb'

$default_logger = Logger.new "onChange"

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

    directory_events = FS::NonTemporaryEvents
        .with_source FS::UniqueEvents
        .with_source FS::AllDirectoryEvents
        .forDirectory dir

    while true do
        events = log_block "wait_for_events" do
            directory_events.wait_for_events
        end

        log_block "list_events" do
            events.each {|event| info "#{event.absolute_name} triggered #{event.flags}"}
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


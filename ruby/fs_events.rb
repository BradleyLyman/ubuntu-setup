require './log.rb'
require "rb-inotify"

# Event is my representation of an interesting file-event
class Event
    # Construct my event from an rb-inotify event
    def self.from_inotify(event)
        Event.new event.absolute_name, event.flags
    end

    # Create an event using the absolute name and a list of flags.
    # @param absolute_name - A string representing the file-path
    # @param flasg - A list of event names which occured on the file
    def initialize(absolute_name, flags)
        @absolute_name = absolute_name
        @flags = flags
    end

    # The 'absolute' path of the file which triggered the event
    # Absolute because it is relative to the original directory being watched
    def absolute_name
        @absolute_name
    end

    # The list of atoms representing the inotify events which occured on the file
    def flags
        @flags
    end

    def add_flags!(more_flags)
        @flags = @flags + more_flags
    end
end

# This decorator represents events which have been processed after being retrieved
# from the event_source
class EventsDecorator
    def initialize(event_source)
        @event_source = event_source
    end

    # Block and wait for a list of events
    def wait_for_events()
        self.process @event_source.wait_for_events
    end

    def process(event_list)
        event_list
    end
end

# This class represents all events in a directory which do not refer to
# temporary files
class NonTemporaryEvents < EventsDecorator
    def self.with_source(event_source)
        NonTemporaryEvents.new event_source
    end

    def initialize(event_source)
        super(event_source)
    end

    # Remove any events for temporary files
    def process(event_list)
        event_list.select do |event|
            non_temp = is_non_temporary event
            if non_temp
                true
            else
                warn "Discarding events for #{event.absolute_name} because it "\
                     "is a temporary file"
                false
            end
        end
    end

    # temporary files have names which are only numbers (34298) or which contain ~
    def is_non_temporary(event)
        name = File.basename(event.absolute_name)
        /[a-zA-Z.]/.match(name) && !/[~]/.match(name)
    end

    private :is_non_temporary
end

# This class represents all events within a directory such that each file only
# has one distinct event object associated with it.
class UniqueEvents < EventsDecorator
    def self.with_source(event_source)
        UniqueEvents.new event_source
    end

    def initialize(event_source)
        super(event_source)
    end

    def process(event_list)
        unique_event_list = []
        event_list.each do |event; uevent|
            uevent = unique_event_list.find do |e|
                e.absolute_name == event.absolute_name
            end
            if uevent
                warn "Merging events on #{uevent.absolute_name}"
                uevent.add_flags! event.flags
            else
                unique_event_list << event
            end
        end
        unique_event_list
    end
end

# This class represents all events on a directory or file
class AllDirectoryEvents
    def self.forDirectory(file)
        AllDirectoryEvents.new file
    end

    # use rb-inotify to create a inotify watch on the file/directory
    def initialize(file)
        @events = []
        @notifier = INotify::Notifier.new

        @notifier.watch(
            file, :recursive, :modify, :close_write, :attrib, :moved_to, :create
        ) do |event|
            @events << event
        end
    end

    # gather all events and map to my event
    def wait_for_events()
        @events.clear
        @notifier.process
        @events.map {|event| Event.from_inotify event}
    end
end


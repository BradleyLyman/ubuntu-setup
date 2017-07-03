DEFAULT = "\e[39m"
BLUE = "\e[34m"
YELLOW = "\e[33m"
MAGENTA = "\e[35m"

LOG_LINE = " <%{app_name}> %{color}%{type} %{msg} #{DEFAULT}"

class Logger
    @@INDENT = "    "
    def initialize(app_name)
        @app_name = app_name
    end

    def info(msg)
        $stdout.puts LOG_LINE % {
            app_name: @app_name,
            color: BLUE,
            type: "[INFO]",
            msg: "#{msg}"
        }
    end

    def warn(msg)
        $stdout.puts LOG_LINE % {
            app_name: @app_name,
            color: YELLOW,
            type: "[WARN]",
            msg: "#{msg}"
        }
    end

    def error(msg)
        $stderr.puts LOG_LINE % {
            app_name: @app_name,
            color: MAGENTA,
            type: "[ERROR]",
            msg: "#{msg}"
        }
    end

    def set_name(name)
        @app_name = name
    end

    def name
        @app_name
    end
end

$default_logger = Logger.new "default"

def info(msg)
    $default_logger.info msg
end

def warn(msg)
    $default_logger.warn msg
end

def error(msg)
    $default_logger.error msg
end

def log_block(name)
    old_name = $default_logger.name
    $default_logger.set_name "#{old_name}.#{name}"
    yield
ensure
    $default_logger.set_name old_name
end

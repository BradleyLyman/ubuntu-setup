LOG_PREFIX = " <--> "
DEFAULT = "\e[39m"
BLUE = "\e[34m"
YELLOW = "\e[33m"
MAGENTA = "\e[35m"

LOG_LINE = LOG_PREFIX + "%{color}%{msg} #{DEFAULT}"

def info(msg)
    $stdout.puts LOG_LINE % {
        color: BLUE,
        msg: "[INFO] #{msg}"
    }
end

def warn(msg)
    $stdout.puts LOG_LINE % {
        color: YELLOW,
        msg: "[WARN] #{msg}"
    }
end

def error(msg)
    $stderr.puts LOG_LINE % {
        color: MAGENTA,
        msg: "[ERROR] #{msg}"
    }
end

package brlyman;

import java.util.Collections;

public class ColoredLogger implements Logger
{
    @Override
    public void info(final String msg)
    {
        for (String line : split_on_newline(msg))
        {
            System.out.println(
                BLUE + indent() + line + DEFAULT
            );
        }
    }

    @Override
    public void warn(final String msg)
    {
        for (String line : split_on_newline(msg))
        {
            System.out.println(
                YELLOW + indent() + line + DEFAULT
            );
        }
    }

    @Override
    public void error(final String msg)
    {
        for (String line : split_on_newline(msg))
        {
            System.out.println(
                MAGENTA + indent() + line + DEFAULT
            );
        }
    }

    @Override
    public void indent(final String name, final Runnable runnable)
    {
        info(name);
        indent_depth += 1;
        try
        {
            runnable.run();
        }
        finally
        {
            indent_depth -= 1;
        }
    }

    private final String indent()
    {
        return String.join("", Collections.nCopies(indent_depth, INDENT));
    }

    private final String[] split_on_newline(final String msg)
    {
        return msg.split("\\n");
    }

    private int indent_depth = 0;

    static private final String BLUE = "\u001B[34m";
    static private final String YELLOW = "\u001B[33m";
    static private final String MAGENTA = "\u001B[35m";
    static private final String DEFAULT = "\u001B[0m";

    private final String INDENT = "   ";
}

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
                BLUE + "[INFO] " + indent() + line + DEFAULT
            );
        }
    }

    @Override
    public void warn(final String msg)
    {
        for (String line : split_on_newline(msg))
        {
            System.out.println(
                YELLOW + "[WARN] " + indent() + line + DEFAULT
            );
        }
    }

    @Override
    public void error(final String msg)
    {
        for (String line : split_on_newline(msg))
        {
            System.out.println(
                MAGENTA + "[ERRR] " + indent() + line + DEFAULT
            );
        }
    }

    @Override
    public void indentOnce()
    {
        indent_depth += 1;
    }

    @Override
    public void resetDepth()
    {
        indent_depth = 0;
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

    private final String INDENT = "  ";
}
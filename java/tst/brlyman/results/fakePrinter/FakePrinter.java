package brlyman.results.fakePrinter;

import java.util.*;

import brlyman.results.*;

public class FakePrinter implements Printer
{
    public FakePrinter()
    {
        log_lines = new ArrayList<>();
    }

    @Override
    public void info(final String msg)
    {
        log_lines.add(new PrinterLine(msg, indent_level, Type.INFO));
    }

    @Override
    public void error(final String msg)
    {
        log_lines.add(new PrinterLine(msg, indent_level, Type.ERRR));
    }

    @Override
    public void block_indent(String block_name, IndentBlock block)
    {
        info(block_name);
        indent_level += 1;
        block.do_with_indent();
        indent_level -= 1;
    }

    public final List<PrinterLine> log_lines;
    private int indent_level = 0;
}

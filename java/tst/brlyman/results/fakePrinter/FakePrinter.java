package brlyman.results.fakePrinter;

import java.util.*;

import brlyman.results.*;

public class FakePrinter implements Printer
{
    public FakePrinter()
    {
        info_log = new ArrayList<>();
    }

    @Override
    public void info(final String msg)
    {
        info_log.add(new PrinterLine(msg, indent_level));
    }

    @Override
    public void block_indent(String block_name, IndentBlock block)
    {
        info(block_name);
        indent_level += 1;
        block.do_with_indent();
        indent_level -= 1;
    }

    public final List<PrinterLine> info_log;
    private int indent_level = 0;
}

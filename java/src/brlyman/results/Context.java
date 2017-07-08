package brlyman.results;

import java.util.*;

/**
 * This class represents a context layer from a test
 * as defined by the HierarchicalContextRunner.
 */
public class Context implements Result
{
    public Context(final String name)
    {
        this.name = name;
        this.results = new ArrayList<>();
    }

    @Override
    public void display(Printer printer)
    {
        printer.block_indent(name, () ->
        {
            results.forEach((result) -> result.display(printer));
        });
    }

    public void addResult(final Result result)
    {
        results.add(result);
    }

    private List<Result> results;
    private final String name;
}

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
        this.contextName = name;
        this.results = new ArrayList<>();
    }

    @Override
    public String name()
    {
        return contextName;
    }

    @Override
    public void display(Printer printer)
    {
        printer.block_indent(contextName, () ->
        {
            results.forEach((result) -> result.display(printer));
        });
    }

    public void getOrCreate(final Result resultToAdd)
    {
        results.stream()
            .filter((result) -> resultToAdd.name() == result.name())
            .findFirst();

    }

    private List<Result> results;
    private final String contextName;
}

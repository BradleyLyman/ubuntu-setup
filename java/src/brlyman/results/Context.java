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
    public String message()
    {
        return null;
    }

    @Override
    public void apply(Process process)
    {
        process.forContext(this, () ->
        {
            results.forEach((result) -> result.apply(process));
        });
    }

    private List<Result> results;
    private final String contextName;
}

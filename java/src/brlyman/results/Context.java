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
        this.children = new HashMap<>();
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
        process.forContext(this);
    }

    public void addResult(final Result result)
    {
        results.add(result);
    }

    public List<Result> results()
    {
        return results;
    }

    public Context childWithName(final String name)
    {
        return children.computeIfAbsent(name, this::createAndAddChild);
    }

    private Context createAndAddChild(final String name)
    {
        final Context child = new Context(name);
        results.add(child);
        return child;
    }

    private List<Result> results;
    private Map<String, Context> children;
    private final String contextName;
}

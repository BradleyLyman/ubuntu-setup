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
        this.results = new HashMap<>();
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

    @Override
    public int priority()
    {
        return 10;
    }

    public void addResult(final Result result)
    {
        results.computeIfPresent(result.name(), (name, existing) ->
        {
            if (result.priority() > existing.priority())
            {
                return result;
            }
            return existing;
        });
        results.putIfAbsent(result.name(), result);
    }

    public List<Result> results()
    {
        List<Result> resultList = new ArrayList<>(results.values());
        Collections.sort(
            resultList,
            (lhs, rhs) -> Integer.compare(lhs.priority(), rhs.priority()));
        return resultList;
    }

    public Context childWithName(final String name)
    {
        return children.computeIfAbsent(name, this::createAndAddChild);
    }

    private Context createAndAddChild(final String name)
    {
        final Context child = new Context(name);
        addResult(child);
        return child;
    }

    private Map<String, Result> results;
    private Map<String, Context> children;
    private final String contextName;
}

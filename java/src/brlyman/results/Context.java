package brlyman.results;

import java.util.*;

import brlyman.results.processes.RelativePriority;

/**
 * This class represents a context layer from a test
 * as defined by the HierarchicalContextRunner.
 */
public class Context implements Result
{
    public Context(final String name)
    {
        this.contextName = name;
        this.testResults = new HashMap<>();
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

    /**
     * Get all of the results in this context.
     * This includes all test results and child contexts.
     */
    public List<Result> results()
    {
        final List<Result> allResults = new ArrayList<>();
        allResults.addAll(testResults.values());
        allResults.addAll(children.values());
        return allResults;
    }

    /**
     * Add the test result ensuring the tree of parent contexts is properly
     * constructed.
     */
    public void addTestResult(
        final List<String> parentContextNames,
        final Result testResult)
    {
        Context currentContext = this;
        for (String name : parentContextNames)
        {
            currentContext = currentContext.childContext(name);
        }
        currentContext.addTestResult(testResult);
    }

    /**
     * Add the test result to this context using result priorities to decide
     * if the result should be kept.
     */
    private void addTestResult(final Result result)
    {
        testResults.computeIfPresent(
            result.name(),
            (name, old) -> Context.useIfHigherPriority(old, result));
        testResults.putIfAbsent(result.name(), result);
    }

    private Context childContext(final String name)
    {
        return children.computeIfAbsent(name, Context::new);
    }

    private static Result useIfHigherPriority(
        final Result toReplace,
        final Result toAdd)
    {
        if (RelativePriority.between(toAdd, toReplace) == 1)
        {
            return toAdd;
        }
        return toReplace;
    }

    private Map<String, Result> testResults;
    private Map<String, Context> children;
    private final String contextName;
}

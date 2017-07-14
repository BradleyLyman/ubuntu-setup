package brlyman;

import org.junit.runner.notification.Failure;
import org.junit.runner.notification.RunListener;

import java.util.*;

import org.junit.runner.Description;
import org.junit.runner.Result;

import brlyman.results.*;

public class TurboListener extends RunListener
{
    public TurboListener(final Logger log)
    {
        this.log = log;
        this.root = new Context("test run");
    }

    public void
    testRunStarted(final Description description) throws Exception
    {
    }

    public void
    testRunFinished(final Result result) throws Exception
    {
        root.apply(new PrintContexts(log));
    }

    public void
    testStarted(final Description description) throws Exception
    {
    }

    public void
    testFinished(final Description description) throws Exception
    {
        root.apply(
            new MergeContexts(
                Arrays.asList(description.getClassName().split("\\$")),
                new Pass(description.getMethodName())));
    }

    public void
    testFailure(final Failure failure) throws Exception
    {
        root.apply(
            new MergeContexts(
                Arrays.asList(
                    failure.getDescription().getClassName().split("\\$")),
                new Fail(
                    failure.getDescription().getMethodName(),
                    failure.getMessage())));
    }

    public void
    testAssumptionFailure(final Failure failure)
    {
    }

    public void
    testIgnored(final Description description) throws Exception
    {
    }

    private final Context root;
    private final Logger log;
}

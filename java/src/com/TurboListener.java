package com;

import org.junit.runner.notification.Failure;
import org.junit.runner.notification.RunListener;

import org.junit.runner.Description;
import org.junit.runner.Result;

public class TurboListener extends RunListener
{

    public TurboListener(final Logger log)
    {
        this.log = log;
    }

    public void
    testRunStarted(final Description description) throws Exception
    {
        log.info("Begin Test Run");
    }

    public void
    testRunFinished(final Result result) throws Exception
    {
        log.info("Test Run Completed");
    }

    public void
    testStarted(final Description description) throws Exception
    {
        // kinda... yuk? Might want to think about a more complete
        // representation for tests in this form

        final String compositeClassName = description.getClassName();
        final String[] names = compositeClassName.split("\\$");

        log.info("test: " + names[0]);
        for (int i = 1; i < names.length; i++)
        {
            log.indentOnce();
            log.info(PREFIX + names[i]);
        }
        log.indentOnce();
        log.info(PREFIX + description.getMethodName());
        log.indentOnce();
    }

    public void
    testFinished(final Description description) throws Exception
    {
        log.resetDepth();
        log.info("");
    }

    public void
    testFailure(final Failure failure) throws Exception
    {
        log.error("test failed " + failure.getMessage());
        log.error("");
        log.resetDepth();
    }

    public void
    testAssumptionFailure(final Failure failure)
    {
        log.warn("test assumption failed " + failure.getMessage());
    }

    public void
    testIgnored(final Description description) throws Exception
    {
        log.warn("test ignored " + description.getMethodName());
    }

    private final Logger log;
    private final String PREFIX = "↳ ";
}

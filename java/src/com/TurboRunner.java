package com;

import java.util.Arrays;
import java.util.Objects;
import java.util.stream.Collectors;

import org.junit.runner.JUnitCore;

public class TurboRunner
{
    public static void main(String args[]) throws Exception
    {
        JUnitCore core = new JUnitCore();
        core.addListener(new TurboListener(log));
        core.run(tests_with_classname(cleaned_name(args[0])));
    }

    private static String cleaned_name(final String raw_name)
    {
        return raw_name
            .replaceAll("./src/", "")
            .replaceAll("./tst/", "")
            .replaceAll("/", ".")
            .replaceAll(".java", "");
    }

    private static Class[] tests_with_classname(final String name)
    {
        return Arrays.asList(
            name + "Test",
            name + "Tests"
        ).stream()
            .map(TurboRunner::class_with_name)
            .filter(Objects::nonNull)
            .collect(Collectors.toList())
            .toArray(new Class[0]);
    }

    private static Class class_with_name(final String name)
    {
        try
        {
            log.info("Search for tests with name: " + name);
            return Class.forName(name);
        }
        catch (Exception ex)
        {
            log.warn("could not find class");
            return null;
        }
    }

    private static Logger log = new ColoredLogger();
}

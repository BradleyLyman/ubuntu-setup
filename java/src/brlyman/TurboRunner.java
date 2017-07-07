package brlyman;

import org.junit.runner.JUnitCore;

public class TurboRunner
{
    public static void main(String args[]) throws Exception
    {
        final Class<?> testClass =
            lookup_class_for(qualified_test_name(args[0]));
        if (testClass == null)
        {
            log.warn("could not find test class for file '" + args[0] + "'");
            return;
        }

        JUnitCore core = new JUnitCore();
        core.addListener(new TurboListener(log));
        core.run(testClass);
    }

    /**
     * This... is a bit nasty.
     * It behaves as required for now, but notably doesn't work if the
     * class name ends with "Tests".
     * TODO:  Refactor to using nio Path perhaps?
     */
    static String qualified_test_name(final String raw_name)
    {
        return raw_name
            .replaceAll("./src/", "")
            .replaceAll("src/", "")
            .replaceAll("./tst/", "")
            .replaceAll("tst/", "")
            .replaceAll("/", ".")
            .replaceAll(".java", "")
            .replaceAll("Test", "")
            + "Test";
    }

    private static Class<?> lookup_class_for(final String name)
    {
        try
        {
            return Class.forName(name);
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    private static Logger log = new ColoredLogger();
}

package brlyman;

import java.util.Arrays;
import java.util.Objects;

import org.junit.runner.JUnitCore;

public class TurboRunner
{
    public static void main(String args[]) throws Exception
    {
        JUnitCore core = new JUnitCore();
        core.addListener(new TurboListener(log));

        log.info("Lookup test classes for [" + String.join(", ", args) + "].");
        Arrays.asList(args).stream()
            .map(TurboRunner::qualified_test_name)
            .map(TurboRunner::lookup_class_for)
            .filter(Objects::nonNull)
            .forEach(core::run);
        log.info("TurboRunner complete!");
    }

    /**
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

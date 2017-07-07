package brlyman;

import org.junit.runner.JUnitCore;

public class TurboRunner
{
    public static void main(String args[]) throws Exception
    {
        JUnitCore core = new JUnitCore();
        core.addListener(new TurboListener(log));
        core.run(test_with_classname(cleaned_name(args[0])));
    }

    static String cleaned_name(final String raw_name)
    {
        return raw_name
            .replaceAll("./src/", "")
            .replaceAll("src/", "")
            .replaceAll("./tst/", "")
            .replaceAll("tst/", "")
            .replaceAll("/", ".")
            .replaceAll(".java", "")
            .replaceAll("Tests", "")
            .replaceAll("Test", "")
            + "Test";
    }

    private static Class<?>[] test_with_classname(final String name)
    {
        return new Class<?>[] { class_with_name(name) };
    }

    private static Class<?> class_with_name(final String name)
    {
        try
        {
            log.info("Search for: " + name);
            return Class.forName(name);
        }
        catch (Exception ex)
        {
            log.warn("Not found:  " + name);
            return null;
        }
    }

    private static Logger log = new ColoredLogger();
}

package brlyman.results;

/**
 * Represents a test which passed.
 */
public class Pass
{
    public Pass(final String test_name)
    {
        this.test_name = test_name;
    }

    public void display(final Printer printer)
    {
        printer.block_indent(test_name, () ->
        {
            printer.info("Done");
        });
    }

    private final String test_name;
}


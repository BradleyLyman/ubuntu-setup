package brlyman.results;

/**
 * Represents a test which passed.
 */
public class Pass implements Result
{
    public Pass(final String test_name)
    {
        this.test_name = test_name;
    }

    @Override
    public String name()
    {
        return test_name;
    }

    @Override
    public void display(final Printer printer)
    {
        printer.block_indent(test_name, () ->
        {
            printer.info("Done");
        });
    }

    private final String test_name;
}


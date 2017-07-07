package brlyman.results;

public class Fail
{
    public Fail(final String testName)
    {
        this.testName = testName;
    }

    public void display(Printer printer)
    {
        printer.block_indent(testName, () -> {});
    }

    private final String testName;
}

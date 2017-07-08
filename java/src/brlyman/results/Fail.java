package brlyman.results;

public class Fail implements Result
{
    public Fail(final String test_name, final String error_msg)
    {
        this.test_name = test_name;
        this.error_msg = error_msg;
    }

    @Override
    public void display(Printer printer)
    {
        printer.block_indent(test_name, () ->
        {
            printer.error(error_msg);
        });
    }

    private final String test_name;
    private final String error_msg;
}

package brlyman.results;

public class Fail implements Result
{
    public Fail(final String test_name, final String error_msg)
    {
        this.test_name = test_name;
        this.error_msg = error_msg;
    }

    @Override
    public String name()
    {
        return test_name;
    }

    @Override
    public String message()
    {
        return "✘\n" + error_msg;
    }

    @Override
    public void apply(final Process process)
    {
        process.forFail(this);
    }

    @Override
    public int priority()
    {
        return 5;
    }

    private final String test_name;
    private final String error_msg;
}

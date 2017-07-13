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
    public String message()
    {
        return "Done";
    }

    @Override
    public void apply(Process process)
    {
        process.forPass(this);
    }

    private final String test_name;
}


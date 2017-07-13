package brlyman.results;

/**
 * This interface represents a test result which can be displayed.
 */
public interface Result
{
    String name();
    String message();
    void apply(Process process);
}

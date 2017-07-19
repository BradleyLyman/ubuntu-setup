package brlyman.results;

/**
 * This interface represents a test result which can be displayed.
 */
public interface Result
{
    default int priority() { return 0; }
    String name();
    String message();
    void apply(Process process);
}

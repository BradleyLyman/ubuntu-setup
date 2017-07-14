package brlyman;

public interface Logger
{
    void indentOnce();
    void resetDepth();
    void indent(String name, Runnable runnable);
    void info(String msg);
    void warn(String msg);
    void error(String msg);
}

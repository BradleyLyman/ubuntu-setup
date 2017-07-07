package brlyman.results;

public interface Printer
{
    public interface IndentBlock
    {
        void do_with_indent();
    }

    void info(String msg);
    void block_indent(String block_name, IndentBlock block);
}

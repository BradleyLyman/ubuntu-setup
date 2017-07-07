package brlyman.results.fakePrinter;

import org.hamcrest.*;

public class LineMatcher
    extends TypeSafeDiagnosingMatcher<PrinterLine>
{
    public enum Indent
    {
        None(0),
        One(1);

        public int value()
        {
            return depth;
        }

        private Indent(int d)
        {
            depth = d;
        }

        private final int depth;
    }

    public static LineMatcher line(final Indent indent, final String line)
    {
        return new LineMatcher(new PrinterLine(line, indent.value()));
    }


    @Override
    public void describeTo(final Description desc)
    {
        desc.appendText("line with indent of ")
            .appendValue(expectedLine.indent_level)
            .appendText(" and value '")
            .appendText(expectedLine.line)
            .appendText("'");
    }

    @Override
    protected boolean matchesSafely(
        final PrinterLine actualLine,
        final Description mismatchDesc)
    {
        boolean match = true;
        if (actualLine.indent_level != expectedLine.indent_level)
        {
            mismatchDesc
                .appendText("actual indent level is ")
                .appendValue(actualLine.indent_level)
                .appendText(". ");
            match = false;
        }

        if (!expectedLine.line.equals(actualLine.line))
        {
            mismatchDesc
                .appendText("actual log line is '")
                .appendText(actualLine.line)
                .appendText("'. ");
            match = false;
        }
        return match;
    }

    private LineMatcher(final PrinterLine expectedLine)
    {
        this.expectedLine = expectedLine;
    }

    private final PrinterLine expectedLine;
}

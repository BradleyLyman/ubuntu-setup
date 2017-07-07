package brlyman.results.fakePrinter;

import lombok.*;

@ToString
@EqualsAndHashCode
@AllArgsConstructor
public class PrinterLine
{
    public final String line;
    public final int indent_level;
}

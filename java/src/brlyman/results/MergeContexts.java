package brlyman.results;

import java.util.*;

public class MergeContexts implements Process
{
    MergeContexts(final Result toMerge)
    {
        this.toMerge = toMerge;
        nameStack = new Stack<>();
    }

    public MergeContexts(
        final List<String> contextNames,
        final Result toMerge)
    {
        this(toMerge);
        for (int i = contextNames.size()-1; i >= 0; i--)
        {
            nameStack.push(contextNames.get(i));
        }
    }

    @Override
    public void forContext(final Context context)
    {
        if (nameStack.empty())
        {
            context.addResult(toMerge);
        }
        else
        {
            context
                .childWithName(nameStack.pop())
                .apply(this);
        }
    }

    final Stack<String> nameStack;
    final Result toMerge;
}

package brlyman.results;

import java.util.*;

public class MergeContexts implements Process
{
    MergeContexts(final Result toMerge)
    {
        this.toMerge = toMerge;
        contextNames = new Stack<>();
    }

    MergeContexts(final String contextName, final Result toMerge)
    {
        this(toMerge);
        contextNames.push(contextName);
    }

    @Override
    public void forContext(final Context context)
    {
        if (contextNames.empty())
        {
            context.addResult(toMerge);
        }
        else
        {
            // TODO: do stuff
        }
    }

    final Stack<String> contextNames;
    final Result toMerge;
}

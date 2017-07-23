package brlyman.results.processes;

import java.util.Comparator;

import brlyman.results.*;
import brlyman.results.Process;

/**
 * This class performs a semantic comparison between two results such that the
 * result with the highest priority (most likely to need investigation) wins.
 */
public class RelativePriority implements Comparator<Result>
{
    @Override
    public int compare(final Result lhs, final Result rhs)
    {
        return Integer.compare(
            Priority.forResult(lhs), Priority.forResult(rhs));
    }

    /**
     * This class represents the priority of a result.
     */
    private static class Priority implements Process
    {
        public static int forResult(final Result result)
        {
            final Priority priority = new Priority();
            result.apply(priority);
            return priority.currentValue;
        }

        @Override
        public void forContext(final Context context)
        {
            currentValue = 2;
        }

        @Override
        public void forPass(final Pass pass)
        {
            currentValue = 0;
        }

        @Override
        public void forFail(final Fail fail)
        {
            currentValue = 1;
        }

        private int currentValue = 0;
    }
}

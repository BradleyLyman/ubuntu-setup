package brlyman.results.processes;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import java.util.Comparator;

import org.junit.Test;
import org.junit.runner.RunWith;

import brlyman.results.*;
import de.bechte.junit.runners.context.HierarchicalContextRunner;

@RunWith(HierarchicalContextRunner.class)
public class RelativePriorityTest
{
    public class given_a_priority_comparator
    {
        @Test
        public void then_context_should_have_highest_priority()
        {
            assertComparison(context, GREATER_THAN, pass);
            assertComparison(context, GREATER_THAN, fail);
            assertComparison(context, EQUAL_TO, context);
        }

        @Test
        public void then_pass_should_have_lowest_priority()
        {
            assertComparison(pass, LESS_THAN, fail);
            assertComparison(pass, LESS_THAN, context);
            assertComparison(pass, EQUAL_TO, pass);
        }

        @Test
        public void then_fail_should_be_higher_than_pass()
        {
            assertComparison(fail, GREATER_THAN, pass);
            assertComparison(fail, EQUAL_TO, fail);
        }

        @Test
        public void then_fail_should_be_less_than_context()
        {
            assertComparison(fail, LESS_THAN, context);
        }
    }

    private void assertComparison(
        final Result lhs, final int expectedResult, final Result rhs)
    {
        assertThat(
            String.format("%s should be %s %s",
                lhs.name(),
                compareToString(expectedResult),
                rhs.name()),
            relativePrority.compare(lhs, rhs), is(equalTo(expectedResult)));
    }

    private final Comparator<Result> relativePrority = new RelativePriority();
    private final Result context = new Context("context");
    private final Result pass = new Pass("pass");
    private final Result fail = new Fail("fail", "");

    private static final int GREATER_THAN = 1;
    private static final int LESS_THAN = -1;
    private static final int EQUAL_TO = 0;

    private static String compareToString(int compareValue)
    {
        switch (compareValue)
        {
            case GREATER_THAN:
                return "GREATER THAN";
            case EQUAL_TO:
                return "EQUAL TO";
            case LESS_THAN:
                return "LESS THAN";
            default:
                return "UNKNOWN COMPARISON";
        }
    }
}


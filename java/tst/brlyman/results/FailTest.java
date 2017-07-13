package brlyman.results;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static brlyman.results.fakePrinter.LineMatcher.*;

import org.junit.*;
import org.junit.runner.*;

import de.bechte.junit.runners.context.HierarchicalContextRunner;

import brlyman.results.fakePrinter.*;

@RunWith(HierarchicalContextRunner.class)
public class FailTest
{
    public class given_a_failed_test
    {
        @SuppressWarnings("unchecked")
        @Test
        public void then_display_should_put_testname_in_infolog()
        {
            failedTest.display(fakePrinter);
            assertThat(
                fakePrinter.log_lines,
                contains(
                    info(Indent.None, TESTNAME),
                    error(Indent.One, ERROR_MSG)));
        }

        private Fail failedTest = new Fail(TESTNAME, ERROR_MSG);
    }

    private final FakePrinter fakePrinter = new FakePrinter();

    static private final String TESTNAME = "some_test_name";
    static private final String ERROR_MSG = "some error message";
}

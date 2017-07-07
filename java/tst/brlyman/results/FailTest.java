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
    public class give_a_failed_test
    {
        @Test
        public void then_display_should_put_testname_in_infolog()
        {
            failedTest.display(fakePrinter);
            assertThat(
                fakePrinter.info_log,
                contains(
                    line(Indent.None, TESTNAME)));
        }

        @Test
        public void then_display_should_put_error_msg_in_errorlog()
        {
            failedTest.display(fakePrinter);
            assertThat(
                fakePrinter.error_log,
                contains(
                    line(Indent.One, ERROR_MSG)));
        }

        private Fail failedTest = new Fail(TESTNAME);
    }

    private final FakePrinter fakePrinter = new FakePrinter();

    static private final String TESTNAME = "some_test_name";
    static private final String ERROR_MSG = "some \n error \n message";
}

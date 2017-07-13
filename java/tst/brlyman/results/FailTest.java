package brlyman.results;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import org.junit.*;
import org.junit.runner.*;

import brlyman.results.fakeProcess.FakeProcess;
import brlyman.results.fakeProcess.FakeProcess.Type;
import de.bechte.junit.runners.context.HierarchicalContextRunner;

@RunWith(HierarchicalContextRunner.class)
public class FailTest
{
    public class given_a_failed_test_with_name_and_error_message
    {
        @Test
        public void then_the_name_should_match_testname()
        {
            assertThat(fail.name(), is(equalTo(TESTNAME)));
        }

        @Test
        public void then_then_message_should_match_errormsg()
        {
            assertThat(fail.message(), is(equalTo(ERROR_MSG)));
        }

        @Test
        public void then_applying_a_process_should_succeed()
        {
            FakeProcess proc = new FakeProcess();
            fail.apply(proc);
            assertThat(proc.lastProcessed(), is(Type.Fail));
        }

        private Result fail = new Fail(TESTNAME, ERROR_MSG);
    }

    static private final String TESTNAME = "some_test_name";
    static private final String ERROR_MSG = "some error message";
}


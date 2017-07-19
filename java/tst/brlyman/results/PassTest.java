package brlyman.results;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import org.junit.*;
import org.junit.runner.*;

import de.bechte.junit.runners.context.HierarchicalContextRunner;

@RunWith(HierarchicalContextRunner.class)
public class PassTest
{
    public class given_a_passed_test_with_name_and_message
    {
        @Test
        public void then_the_name_should_match_testname()
        {
            assertThat(pass.name(), is(equalTo(TESTNAME)));
        }

        @Test
        public void then_the_message_should_be_done()
        {
            assertThat(pass.message(), is(equalTo("✔")));
        }

        private Result pass = new Pass(TESTNAME);
    }

    static private final String TESTNAME = "some_fake_test_name";
}

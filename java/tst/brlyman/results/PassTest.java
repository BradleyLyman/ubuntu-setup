package brlyman.results;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static brlyman.results.fakePrinter.LineMatcher.*;

import org.junit.*;
import org.junit.runner.*;
import de.bechte.junit.runners.context.HierarchicalContextRunner;

import brlyman.results.fakePrinter.*;

@RunWith(HierarchicalContextRunner.class)
public class PassTest
{
    public class given_a_passed_test
    {
		@SuppressWarnings("unchecked")
		@Test
        public void then_print_should_output_the_test_result() throws Exception
        {
            pass.display(fakePrinter);
            assertThat(
                fakePrinter.log_lines,
                contains(
                    info(Indent.None, TESTNAME),
                    info(Indent.One, "Done")));
        }

        private Pass pass = new Pass(TESTNAME);
    }

    private final FakePrinter fakePrinter = new FakePrinter();

    static private final String TESTNAME = "some_fake_test_name";
}

package brlyman.results;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static brlyman.results.fakePrinter.LineMatcher.*;

import org.junit.*;
import org.junit.runner.RunWith;

import brlyman.results.fakePrinter.*;
import de.bechte.junit.runners.context.HierarchicalContextRunner;

@RunWith(HierarchicalContextRunner.class)
public class ContextTest
{
    @Test
    public void aoeu() {}

    public class when_the_context_is_empty
    {
        @Test
        public void then_the_output_should_be_just_the_name()
        {
            context.display(fakePrinter);
            assertThat(
                fakePrinter.log_lines,
                contains(
                    info(Indent.None, CONTEXT_NAME)));
        }

        private Context context = new Context(CONTEXT_NAME);
    }

    public class when_the_context_has_tests_and_subcontexts
    {
        @Before
        public void setup_context_results()
        {
            context.addResult(new Pass(PASS));
            context.addResult(new Fail(FAIL, FAIL_MSG));
            context.addResult(new Context(SUB_CTX_NAME));
        }

        @SuppressWarnings("unchecked")
        @Test
        public void then_the_results_should_all_display_correctly()
        {
            context.display(fakePrinter);
            assertThat(
                fakePrinter.log_lines,
                contains(
                    info(Indent.None, CONTEXT_NAME),

                    info(Indent.One, PASS),
                    info(Indent.Two, "Done"),

                    info(Indent.One, FAIL),
                    error(Indent.Two, FAIL_MSG),

                    info(Indent.One, SUB_CTX_NAME)));
        }

        private Context context = new Context(CONTEXT_NAME);
    }

    private final FakePrinter fakePrinter = new FakePrinter();

    static private final String CONTEXT_NAME = "context name";
    static private final String SUB_CTX_NAME = "sub context name";
    static private final String PASS = "passed test name";
    static private final String FAIL = "failed test name";
    static private final String FAIL_MSG = "failed test msg";
}

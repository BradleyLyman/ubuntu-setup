package brlyman.results;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import org.junit.*;
import org.junit.runner.RunWith;

import de.bechte.junit.runners.context.HierarchicalContextRunner;

@RunWith(HierarchicalContextRunner.class)
public class ContextTest
{
    public class when_the_context_is_empty
    {
        @Test
        public void then_the_output_should_be_just_the_name()
        {
        }

        private Context context = new Context(CONTEXT_NAME);
    }

    static private final String CONTEXT_NAME = "context name";
    static private final String SUB_CTX_NAME = "sub context name";
    static private final String PASS = "passed test name";
    static private final String FAIL = "failed test name";
    static private final String FAIL_MSG = "failed test msg";
}

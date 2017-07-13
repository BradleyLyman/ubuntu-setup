package brlyman.results;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import org.junit.*;
import org.junit.runner.RunWith;

import brlyman.results.fakeProcess.FakeProcess;
import brlyman.results.fakeProcess.FakeProcess.Type;
import de.bechte.junit.runners.context.HierarchicalContextRunner;

@RunWith(HierarchicalContextRunner.class)
public class ContextTest
{
    public class given_a_named_context
    {
        @Test
        public void then_the_context_should_always_have_a_name()
        {
            assertThat(context.name(), is(equalTo(CONTEXT_NAME)));
        }

        @Test
        public void then_the_message_should_be_null()
        {
            assertThat(context.message(), is(nullValue()));
        }

        public class when_the_context_is_empty
        {
            @Test
            public void then_a_process_should_not_handle_any_children()
            {
                FakeProcess proc = new FakeProcess();
                context.apply(proc);
                assertThat(proc.lastProcessed(), is(Type.Context));
            }
        }

        public class when_the_context_has_chlidren
        {
            @Before
            public void setup_context_children()
            {
                context.addResult(new Pass("p1"));
                context.addResult(new Fail("f1", "fmsg"));
            }

            @Test
            public void then_the_process_should_handle_each_child()
            {
                FakeProcess proc = new FakeProcess();
                context.apply(proc);
                assertThat(
                    proc.allProcessed,
                    containsInAnyOrder(
                        Type.Context,
                        Type.Pass,
                        Type.Fail));
            }
        }

        private Context context = new Context(CONTEXT_NAME);
    }

    static private final String CONTEXT_NAME = "context name";
}

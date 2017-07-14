package brlyman.results;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import org.junit.*;
import org.junit.runner.RunWith;

import de.bechte.junit.runners.context.HierarchicalContextRunner;

@RunWith(HierarchicalContextRunner.class)
public class ContextTest
{
    public class given_a_named_context
    {
        @Test
        public void then_the_context_should_always_have_a_name()
        {
            assertThat(root.name(), is(equalTo(CONTEXT_NAME)));
        }

        @Test
        public void then_the_message_should_be_null()
        {
            assertThat(root.message(), is(nullValue()));
        }

        @Test
        public void then_there_should_be_no_children()
        {
            assertThat(root.results(), hasSize(0));
        }

        public class when_accessing_a_new_child_context
        {
            @Before
            public void access_child_context()
            {
                childContext = root.childWithName(childName);
            }

            @Test
            public void then_the_child_should_be_created()
            {
                assertThat(childContext, is(notNullValue()));
            }

            @Test
            public void then_the_child_should_be_in_root_results()
            {
                assertThat(root.results(), hasSize(1));
                assertThat(root.results(), hasItem(childContext));
            }

            @Test
            public void then_repeated_access_shouldnt_change_the_child()
            {
                assertThat(
                    childContext,
                    is(equalTo(root.childWithName(childName))));
            }

            @Test
            public void then_accessing_another_child_should_create_new()
            {
                assertThat(
                    childContext,
                    is(not(equalTo(root.childWithName("otherchild")))));
            }

            private Context childContext;
            private final String childName = "child context name";
        }

        private Context root = new Context(CONTEXT_NAME);
    }

    static private final String CONTEXT_NAME = "context name";
}

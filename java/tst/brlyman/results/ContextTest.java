package brlyman.results;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import java.util.Arrays;
import java.util.List;

import org.junit.*;
import org.junit.runner.RunWith;

import de.bechte.junit.runners.context.HierarchicalContextRunner;

@RunWith(HierarchicalContextRunner.class)
public class ContextTest
{
    public class given_an_empty_context
    {
        @Test
        public void then_context_should_have_name()
        {
            assertThat(context.name(), is(notNullValue()));
        }

        @Test
        public void then_context_should_have_no_message()
        {
            assertThat(context.message(), is(nullValue()));
        }

        public class when_a_test_result_is_added
        {
            @Before
            public void add_result()
            {
                context.addTestResult(
                    Arrays.asList(parent1, parent2),
                    testResult);
            }

            @Test
            public void then_results_should_contain_test_result()
            {
                // kinda clumsy -- maybe add an equality visitor?
                Context p1 = (Context)context.results().get(0);
                Context p2 = (Context)p1.results().get(0);
                assertThat(
                    p2.results(),
                    hasItem(testResult));
            }

            private final Result testResult = new Pass("passed test");
            private final String parent1 = "parent1";
            private final String parent2 = "parent2";
        }
    }

    public class given_a_context_with_a_pass_result
    {
        @Before
        public void add_pass()
        {
            context.addTestResult(noParents, pass);
        }

        public class when_adding_a_result_with_the_same_name
        {
            @Test
            public void then_adding_another_pass_should_do_nothing()
            {
                context.addTestResult(noParents, new Pass(pass.name()));
                assertThat(
                    "There should still only be one result",
                    context.results(), hasSize(1));
                assertThat(
                    "The result should remain unchanged.",
                    context.results(), hasItem(pass));
            }

            @Test
            public void then_adding_a_fail_should_replace_the_pass()
            {
                final Fail fail = new Fail(pass.name(), null);
                context.addTestResult(noParents, fail);
                assertThat(
                    "There should still only be one result",
                    context.results(), hasSize(1));
                assertThat(
                    "The result should be replaced with the fail",
                    context.results(), hasItem(fail));
            }
        }

        private final Pass pass = new Pass("pass_test_result");
    }

    public class given_a_context_with_a_fail_result
    {
        @Before
        public void add_fail()
        {
            context.addTestResult(noParents, fail);
        }

        public class when_adding_a_result_with_the_same_name
        {
            @Test
            public void then_adding_a_pass_should_do_nothing()
            {
                context.addTestResult(noParents, new Pass(fail.name()));
                assertThat(
                    "There should only be one result",
                    context.results(), hasSize(1));
                assertThat(
                    "The fail should remain unchanged",
                    context.results(), hasItem(fail));
            }

            @Test
            public void then_adding_a_fail_should_do_nothing()
            {
                context.addTestResult(noParents, new Fail(fail.name(), null));
                assertThat(
                    "There should only be one result",
                    context.results(), hasSize(1));
                assertThat(
                    "The fail should remain unchanged",
                    context.results(), hasItem(fail));
            }
        }

        private final Fail fail = new Fail("fail_test_result", null);
    }

    private final Context context = new Context("some_context_name");
    private static final List<String> noParents = Arrays.asList();
}

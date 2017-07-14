package brlyman.results;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import org.junit.*;
import org.junit.runner.RunWith;

import de.bechte.junit.runners.context.HierarchicalContextRunner;

@RunWith(HierarchicalContextRunner.class)
public class MergeContextsTest
{
    public class given_a_root_context
    {
        @Test
        public void then_merging_a_result_should_add_to_the_root()
        {
            final Result result = new Pass("aoeu");
            MergeContexts mergeProcess =
                new MergeContexts(result);

            root.apply(mergeProcess);

            assertThat(
                "root should only have one result",
                root.results(), hasSize(1));
            assertThat(
                "root should contain the added result",
                root.results(), hasItem(result));
        }

        public class when_a_child_context_with_result_is_merged
        {
            @Before
            public void merge_subcontext()
            {
                root.apply(new MergeContexts(subContextName, result));
            }

            @Test
            public void then_root_should_have_one_child()
            {
                assertThat(root.results(), hasSize(1));
            }

            @Test
            public void then_it_should_have_one_child()
            {
                assertThat(
                    root.childWithName(subContextName).results(),
                    hasSize(1));
            }

            @Test
            public void then_its_results_should_match_merged()
            {
                assertThat(
                    root.childWithName(subContextName).results(),
                    contains(result));
            }

            private final String subContextName = "sub context 1";
            private final Result result = new Pass("pass");
        }

        private Context root = new Context("root_context");
    }
}

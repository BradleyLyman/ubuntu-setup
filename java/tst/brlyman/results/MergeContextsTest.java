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

        @Test
        public void then_merging_a_context_should_create_tree()
        {
            final String subContextName = "sub context 1";
            final Result result = new Pass("pass result");
            MergeContexts mergeProcess =
                new MergeContexts(subContextName, result);

            root.apply(mergeProcess);

            assertThat(root.results(), hasSize(1));

            // TODO: get sub context verify result is present
        }

        private Context root = new Context("root_context");
    }
}

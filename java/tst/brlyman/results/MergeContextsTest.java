package brlyman.results;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import java.util.*;

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

        public class when_child_contexts_with_a_result_are_merged
        {
            @Before
            public void merge_subcontext()
            {
                root.apply(
                    new MergeContexts(
                        Arrays.asList(sub1, sub2),
                        result));
            }

            @Test
            public void then_root_should_have_one_child()
            {
                assertThat(root.results(), hasSize(1));
            }

            @Test
            public void then_child_should_have_one_child()
            {
                assertThat(
                    root.childWithName(sub1).results(),
                    hasSize(1));
            }

            @Test
            public void then_child_results_should_match_merged()
            {
                assertThat(
                    root.childWithName(sub1).childWithName(sub2).results(),
                    contains(result));
            }

            private final String sub1 = "sub context 1";
            private final String sub2 = "sub context 2";
            private final Result result = new Pass("pass");
        }

        private Context root = new Context("root_context");
    }
}

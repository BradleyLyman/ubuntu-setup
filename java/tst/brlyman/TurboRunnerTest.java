package brlyman;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.equalTo;

import org.junit.Test;
import org.junit.runner.RunWith;

import de.bechte.junit.runners.context.HierarchicalContextRunner;

@RunWith(HierarchicalContextRunner.class)
public class TurboRunnerTest
{
    public class given_a_src_file_path
    {
        @Test
        public void then_all_name_variants_should_be_resolved()
        {
            assertFound("./src/brlyman/TurboRunner.java", testClassName);
            assertFound("src/brlyman/TurboRunner.java", testClassName);
            assertFound("brlyman/TurboRunner.java", testClassName);
        }
    }

    public class given_a_tst_file_path
    {
        @Test
        public void then_all_singular_name_variants_should_be_resolved()
        {
            assertFound("./tst/brlyman/TurboRunnerTest.java", testClassName);
            assertFound("tst/brlyman/TurboRunnerTest.java", testClassName);
            assertFound("brlyman/TurboRunnerTest.java", testClassName);
        }

        @Test
        public void then_all_plural_name_variants_should_be_resolved()
        {
            assertFound("./tst/brlyman/TurboRunnerTests.java", testClassName);
            assertFound("tst/brlyman/TurboRunnerTests.java", testClassName);
            assertFound("brlyman/TurboRunnerTests.java", testClassName);
        }
    }

    static private void
    assertFound(final String filename, final String expectedTestName)
    {
        assertThat(
            filename + " should resolve to " + expectedTestName,
            TurboRunner.cleaned_name(filename),
            is(equalTo(expectedTestName))
        );
    }

    private final String testClassName = "brlyman.TurboRunnerTest";
}

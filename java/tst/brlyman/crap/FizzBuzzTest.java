package brlyman.crap;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

import org.junit.Test;
import org.junit.runner.RunWith;

import de.bechte.junit.runners.context.HierarchicalContextRunner;

@RunWith(HierarchicalContextRunner.class)
public class FizzBuzzTest
{
    public class given_a_number
    {
        public class when_the_number_is_a_multiple_of_three
        {
            @Test
            public void then_FizzBuzz_should_print_fizz() throws Exception
            {
                assertThat(fizzBuzz.print(3), is("fizz"));
            }
        }

        public class when_the_number_is_a_multiple_of_five
        {
            @Test
            public void then_FizzBuzz_should_print_buzz() throws Exception
            {
                assertThat(fizzBuzz.print(5), is("buzz"));
            }
        }
    }

    private final FizzBuzz fizzBuzz = new FizzBuzz();
}


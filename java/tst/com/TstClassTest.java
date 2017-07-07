package com;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.notNullValue;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

import de.bechte.junit.runners.context.HierarchicalContextRunner;

@RunWith(HierarchicalContextRunner.class)
public class TstClassTest
{
    public class given_a_file_path
    {
        @Before
        public void create_test_class() throws Exception
        {
            testClass = TstClass.for_file(path);
        }

        @Test
        public void then_test_name_should_exist() throws Exception
        {
            assertThat(
                "name should not be null",
                testClass.name(), is(notNullValue())
            );
        }

        private TstClass testClass;
        private final String path = "./src/some/file/pathclass.java";
    }
}

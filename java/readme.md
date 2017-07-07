remember to set the classpath!

context
  test
    done
  test
    done
  test
    failed!
    msg

  context
    test
      done

  context
    test
      done
    test
      done


tree structure with two nodes types: context, test
two types of test, pass and fail

when printing, for a context
  display the context
  write each test + results
  repeat for each child context



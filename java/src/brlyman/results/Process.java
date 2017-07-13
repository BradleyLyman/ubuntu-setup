package brlyman.results;

public interface Process
{
    default void forContext(Context context) {};
    default void forPass(Pass pass) {};
    default void forFail(Fail fail) {};
}

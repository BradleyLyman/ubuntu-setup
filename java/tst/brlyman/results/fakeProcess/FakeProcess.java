package brlyman.results.fakeProcess;

import brlyman.results.*;
import brlyman.results.Process;

public class FakeProcess implements Process
{
    public static enum Type
    {
        Pass, Fail, Context, None
    }

    @Override
    public void forPass(final Pass pass)
    {
        lastProcessed = Type.Pass;
    }

    @Override
    public void forFail(final Fail fail)
    {
        lastProcessed = Type.Fail;
    }

    @Override
    public void forContext(final Context context, Runnable runnable)
    {
        lastProcessed = Type.Context;
    }

    public Type lastProcessed()
    {
        return lastProcessed;
    }

    private Type lastProcessed = Type.None;
}

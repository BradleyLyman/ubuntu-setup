package brlyman.results.fakeProcess;

import java.util.*;

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
        allProcessed.add(Type.Pass);
    }

    @Override
    public void forFail(final Fail fail)
    {
        allProcessed.add(Type.Fail);
    }

    @Override
    public void forContext(final Context context)
    {
        allProcessed.add(Type.Context);
    }

    public Type lastProcessed()
    {
        return allProcessed.get(allProcessed.size()-1);
    }

    public List<Type> allProcessed = new ArrayList<>();
}

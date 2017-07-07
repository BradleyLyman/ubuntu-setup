package com;

import lombok.NonNull;

public class TstClass
{
    public static TstClass for_file(@NonNull final String path)
    {
        return new TstClass(path);
    }

    public String name()
    {
        return path;
    }

    private TstClass(final String path)
    {
        this.path = path;
    }

    private final String path;
}

package com;

public interface Logger
{
    void indentOnce();
    void resetDepth();
    void info(String msg);
    void warn(String msg);
    void error(String msg);
}

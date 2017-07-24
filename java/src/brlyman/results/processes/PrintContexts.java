package brlyman.results.processes;

import brlyman.Logger;

import brlyman.results.*;
import brlyman.results.Process;

public class PrintContexts implements Process
{
    public PrintContexts(final Logger logger)
    {
        this.logger = logger;
    }

    @Override
    public void forPass(final Pass pass)
    {
        logger.indent(
            PREFIX + pass.name(),
            () -> logger.info(pass.message()));
    }

    @Override
    public void forFail(final Fail fail)
    {
        logger.indent(
            PREFIX + fail.name(),
            () -> logger.error(fail.message()));
    }

    @Override
    public void forContext(final Context context)
    {
        logger.indent(CONTEXT_PREFIX + context.name(), () ->
        {
            context.results().forEach((result) -> result.apply(this));
        });
    }

    private final Logger logger;
    private final String PREFIX = ":";
    private final String CONTEXT_PREFIX = "↳";
}

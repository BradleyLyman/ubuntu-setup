#!/bin/bash

BASE_DIR=~/.config/jdt

exec java \
  -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 \
  -javaagent:$BASE_DIR/lombok.jar \
  -Xbootclasspath/a:$BASE_DIR/lombok.jar \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.level=ALL  \
  -noverify \
  -Xmx1G \
  -jar $BASE_DIR/plugins/org.eclipse.equinox.launcher_1.4.0.v20161219-1356.jar \
  -configuration $BASE_DIR/config_linux \
  -data ~/.config/jdt/workspace \
  2>~/.config/jdt/err.log

#!/usr/bin/env julia

packages = [
  "bash-completion",
  "build-essential",
  "cmake",
  "libcurl4",
  "libcurl4-openssl-dev",
  "libssl-dev",
  "libxml2",
  "libxml2-dev",
  "libssl1.1",
  "pkg-config",
  "ca-certificates",
  "xclip"
];

run(`sudo apt-get install -yqq $packages`)

repo_url = "https://github.com/lastpass/lastpass-cli"
run(`git clone $repo_url`)

cd("lastpass-cli")

run(`make`)
run(`sudo make install`)


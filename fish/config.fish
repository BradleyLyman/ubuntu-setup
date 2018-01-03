set -x PATH $PATH ~/.config/mybin
set -x PATH $PATH /apollo/env/SDETools/bin/
set -x PATH $PATH ~/.cargo/bin/
set -x PATH $PATH ~/.local/bin/

set -x LD_LIBRARY_PATH $LD_LIBRARY_PATH (rustc --print sysroot)/lib

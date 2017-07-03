# New System Instructions

* Run remove_desktop.sh to delete all of the default crappy ubuntu desktop stuff
* Run update_keyboard.sh to update the keyboard layout
* Run install_ruby.sh
* Run install_subpackages.rb

# Add New Setup

Create a new directory which will contain all relavent files.
Within the new directory create a new file 'install.rb'.
This file will be invoked by install_subpackages.rb.

By convention all install scripts handle a '-u' cli arg which triggers an uninstall operation.


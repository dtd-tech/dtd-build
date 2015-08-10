# Using the dtd-build tools

Once installed the dtd-build script can be used to download sources and build the components of the DTD distribution.

dtd-build all
  will download all source materials and build the final distributables.

dtd-build source <composer|drush|desktop|server|tools|tracks[ %track]|win|all>
  Will download the source materials for the specified component or all at once.

dtd-build build <composer|drush|tracks|desktop|server|vm|vagrant|tools|win|usb|all>

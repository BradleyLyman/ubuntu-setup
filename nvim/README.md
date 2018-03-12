# NVIM Notes

## YouCompleteMe - Java

Java completion normally creates a unique workspace each time vim is launched.
This is fine for smallish projects, but mega-slow for big projects (which are
typical while at work).

For large projects consider setting ycmd to reuse the workspace (accepting
the potential for a corrupted workspace/parallel updates).

Go to 'plugged/YouCompleteMe/third_party/ycmd/ycmd/default_settings.json'
and change
  "java_jdtls_use_clean_workspace": 1
to
  "java_jdtls_use_clean_workspace": 0

Remember that :YcmDebugInfo can be used to find the workspace directory

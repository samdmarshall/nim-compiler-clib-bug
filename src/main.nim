
import strformat

import notmuch


proc main() =
  echo(fmt"version: {LIBNOTMUCH_MAJOR_VERSION}.{LIBNOTMUCH_MINOR_VERSION}.{LIBNOTMUCH_MICRO_VERSION}")

when isMainModule:
  main()

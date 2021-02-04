
import os
import strformat

import notmuch

template checkStatus(status: notmuch_status_t) =
  case status
  of NOTMUCH_STATUS_SUCCESS:
    discard
  else:
    echo("Error: " & $status_to_string(status))
    quit(QuitFailure)


proc main() =
  echo(fmt"notmuch library version: {LIBNOTMUCH_MAJOR_VERSION}.{LIBNOTMUCH_MINOR_VERSION}.{LIBNOTMUCH_MICRO_VERSION}")

  var database: notmuch_database_t
  var notmuch_database_path = getCurrentDir()

  let create_status = create(notmuch_database_path, addr database)
  case create_status
  of NOTMUCH_STATUS_FILE_ERROR:
    let open_status = open(notmuch_database_path, NOTMUCH_DATABASE_MODE_READ_WRITE, addr database)
    checkStatus(open_status)
    echo "opened database!"
  of NOTMUCH_STATUS_SUCCESS:
    echo "successfully created database!"
  else:
    checkStatus(create_status)

  let close_status = database.close()
  checkStatus(close_status)

  let destroy_status = database.destroy()
  checkStatus(destroy_status)

when isMainModule:
  main()

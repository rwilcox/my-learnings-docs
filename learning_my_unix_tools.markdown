---
path: "/learnings/my_unix_tools"
title: "Learnings: My Unix Tools"
---

# <<Learning_My_Unix_Tools>>

## <<UnixEpochTimeUtilities>>

    date "+%s"
    1425048734


    # convert is8601 datestamp to epoch seconds
    ruby -e 'require "date"; puts(DateTime.iso8601($*[0]).to_time.to_i)' "2015-02-27T14:50:34+00:00"


    # convert seconds since epoch to Ruby DateTime objects...
    ruby -e 'require "date"; puts DateTime.strptime($*[0], "%s")' 1425048634


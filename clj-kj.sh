#!/bin/bash -e

# joker issue types:
#  Read error
#  Parse error
#  Parse warning
#  Exception

# joker:   <filename>:<line>:<column>: <issue type>: <message>
# kakoune: <filename>:<line>:<column>: <error|warn>: <message>

# joker --lint $@ 2>&1 | sed 's/ Read error:/ error:/g; s/ Parse error:/ error:/g; s/ Parse warning:/ warn:/g; s/ Exception:/ error:/g'
joker --lint $@ 2>&1 | awk -F ':' '$4 = ($4 ~ /warn/ ? "warn" : "error") { printf "%s:%s:%s: %s: %s\n", $1, $2, $3, $4, $5 }'

#!/bin/bash -e

# joker issue types:
#  Read error
#  Parse error
#  Parse warning
#  Exception

# joker:   <filename>:<line>:<column>: <issue type>: <message>
# kakoune: <filename>:<line>:<column>: <error|warn>: <message>

joker --lint $@ 2>&1 | awk -F ':' '$4 = ($4 ~ /warn/ ? "warn" : "error") { printf "%s:%s:%s: %s: %s\n", $1, $2, $3, $4, $5 }'

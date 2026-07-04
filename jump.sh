#!/bin/bash
TARGET=$("$HERDR_BIN_PATH" agent list | jq -r '
  [.result.agents[] | select(.agent_status == "done")] as $agents |
  if ($agents | length) == 0 then
    empty
  else
    ($agents | map(.focused)) | index(true) as $focused_idx |
    if $focused_idx == null then
      $agents[0].terminal_id
    else
      $agents[($focused_idx + 1) % ($agents | length)].terminal_id
    end
  end
')

if [ -n "$TARGET" ]; then
    "$HERDR_BIN_PATH" agent focus "$TARGET"
fi

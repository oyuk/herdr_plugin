#!/bin/bash
set -euo pipefail

STATUS="${1:-}"
case "$STATUS" in
  done|idle|blocked) ;;
  *) exit 2 ;;
esac

TARGET=$("$HERDR_BIN_PATH" agent list | jq -r --arg status "$STATUS" '
  [.result.agents[] | select(.agent_status == $status)] as $agents |
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

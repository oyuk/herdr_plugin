#!/bin/bash
TARGET=$("$HERDR_BIN_PATH" agent list | jq -r '.result.agents[] | select(.agent_status == "done") | .terminal_id' | head -n 1)

if [ -n "$TARGET" ]; then
    "$HERDR_BIN_PATH" agent focus "$TARGET"
fi

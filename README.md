# herdr_plugin

[herdr](https://github.com/herdr) のプラグイン `jump-to-agent`。エージェント一覧から特定ステータスのエージェントを探して、その端末にフォーカスをジャンプする。

## Actions

| Action | 説明 |
|---|---|
| `jump` | ステータスが `done` の最初のエージェントにジャンプ |
| `jump_not_done` | ステータスが `done` 以外の最初のエージェントにジャンプ |

## Requirements

- macOS
- `jq`

## Install

```sh
herdr plugin install <owner>/herdr_plugin
```

## Keybinding

`~/.config/herdr/config.toml` に以下を追加する。`<plugin_id>` は `herdr plugin list --json` で確認したIDに置き換える。

```toml
[[keys.command]]
key = "prefix+d"
type = "plugin_action"
command = "<plugin_id>.jump"
description = "jump to done agent"

[[keys.command]]
key = "prefix+n"
type = "plugin_action"
command = "<plugin_id>.jump_not_done"
description = "jump to not done agent"
```

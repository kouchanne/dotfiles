# mise 用の fish 設定追加

## Context
mise は `brew "mise"` で導入済み（`dot_Brewfile:16`、`/opt/homebrew/bin/mise`、v2026.11.8）だが、
fish 側に有効化設定がなく、ディレクトリ移動時にツールバージョン/環境変数が切り替わらない。
公式 (`mise activate --help`) では fish は `~/.config/fish/config.fish` に
`mise activate fish | source` を一度書けばよい。

## 必要な設定
```fish
# mise (version manager)
if command -q mise
    mise activate fish | source
end
```
- `mise` が PATH 上にある必要がある → 既存の `set -x PATH /opt/homebrew/bin $PATH`（config.fish 1行目）より後に置く。
- `status is-interactive` ガードは不要（config.fish は対話シェル向けの内容のみで、公式例も無条件）。eza と同様に `command -q` ガードで未インストール環境でも壊れないようにする。
- 補完は Homebrew 版が fish 補完を自動配置するため追加設定不要。

## 変更ファイル
- `dot_config/fish/config.fish`（chezmoi source。適用は `chezmoi apply`）
  - 配置: `# Node.js`（Volta）ブロックの直後、`# eza` の前。PATH 系設定がすべて終わった後に有効化することで、mise 管理ツールが Volta / go/bin より優先される。

## 注意点（要確認事項として報告）
- 現在 Node は Volta 管理（`VOLTA_HOME`）。mise で node も管理する場合は競合するため、移行時に Volta ブロックを削除する必要がある。今回は Volta ブロックは触らない（mise が優先されるだけ）。
- `~/.config/mise/config.toml` は未作成。ツール定義は本タスクの対象外。

## 検証
1. `chezmoi diff` で config.fish のみ差分が出ることを確認 → `chezmoi apply`
2. `fish -ic 'mise doctor'` で `activated: yes` を確認
3. `fish -ic 'echo $PATH | tr " " "\n" | head'` で mise 管理パスが PATH に入ることを確認

# dotfiles

My personal dotfiles configuration managed with chezmoi.

## Prerequisites

- macOS (this configuration is optimized for macOS)
- Xcode Command Line Tools (required for Homebrew and development tools)

## How to Setup

### MAC

1. Install Xcode Command Line Tools (requires user interaction):
```sh
xcode-select --install
```

2. Install chezmoi and apply dotfiles:
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/bin init --apply https://github.com/kouchanne/dotfiles.git
```

The setup will automatically:
- Install Homebrew (if not already installed)
- Install all packages defined in Brewfile
- Install Fisher plugin manager for Fish shell
- Configure all dotfiles

### Other Platforms

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/bin init --apply https://github.com/kouchanne/dotfiles.git
```

Note: This configuration is optimized for macOS. Some features may not work on other platforms.

## Basic Usage

### Add a new dotfile

```sh
chezmoi add ~/.config/foo/bar.conf
```

This command adds the file to chezmoi's source directory.

### Edit a dotfile

```sh
chezmoi edit ~/.config/foo/bar.conf
```

This opens the source file in your editor.

### Apply changes

```sh
chezmoi apply
```

This applies all changes from the source directory to your home directory.

### Check what would change

```sh
chezmoi diff
```

This shows the differences between your home directory and chezmoi's source state.

### Update from remote repository

```sh
chezmoi update
```

This pulls the latest changes from your remote repository and applies them.

### Remove a file from chezmoi

```sh
chezmoi forget ~/.config/foo/bar.conf
```

This removes the file from chezmoi management but keeps it in your home directory.

### Common Workflow

1. Make changes to your dotfiles:
   ```sh
   chezmoi edit ~/.bashrc
   ```

2. Preview what will change:
   ```sh
   chezmoi diff
   ```

3. Apply the changes:
   ```sh
   chezmoi apply
   ```

4. Commit and push to Git:
   ```sh
   chezmoi cd
   git add .
   git commit -m "Update configuration"
   git push
   ```

## Agent Status (Zellij Attention Inbox)

Zellij 0.46+ の Attention Inbox で、Claude Code / Codex の状態（作業中・承認待ち・完了・エラー）を全セッション横断で確認できる。
Claude Code 2.1.295+ / Codex CLI 0.163.0+ は OSC 7501 を自前で出力するため、エージェント側の設定は不要。

キーは通常モードから押す（デフォルトモードは normal。`Ctrl g` は locked との切り替え）。

| 操作 | キー |
|---|---|
| Attention Inbox を開く | `Ctrl o` → `i` |
| 次に対応が必要なペインへ移動 | `Ctrl o` → `n` |
| 現在のセッションの通知をミュート | `Ctrl o` → `u` |
| Session Manager を開く | `Ctrl o` → `w` |
| ペイン名を変更（通知ラベルになる） | `Ctrl p` → `c` |
| プレビュー先へ入力（承認操作など） | `Alt Enter` |
| 並び替え / 消去 / ミュート（Inbox 内） | `s` / `c` / `m` |

プレビューからの入力は対象ペインへ実際に送られる。承認する前にセッション名・ペイン名・要求内容を確認すること。
設定は `dot_config/zellij/config.kdl` の `attention` ブロックと session モードの bind。

状態が出ないときの確認順: zellij が 0.46+ か → エージェントが対応バージョンか → エージェント側で状態通知を無効にしていないか（`CLAUDE_CODE_DISABLE_TERMINAL_TITLE`）→ 未対応アプリは通知/ベル設定。

## Troubleshooting

### Terminal fails to start or zellij not found

If Alacritty fails to start or shows "zellij not found" error:

```sh
brew install zellij
```

Then restart Alacritty.

### Fisher plugins not installing

If Fish shell plugins are not working:

1. Install Fisher manually:
```sh
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

2. Install plugins:
```sh
fisher update
```

### Homebrew packages failed to install

If some packages failed during initial setup:

```sh
cd ~/.local/share/chezmoi
brew bundle --file=dot_Brewfile
```

### Startup scripts not running

Startup scripts in `startup/mac/` only run once per machine. To re-run them:

```sh
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply
```

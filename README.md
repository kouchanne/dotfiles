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

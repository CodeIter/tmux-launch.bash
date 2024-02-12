# Tmux Launcher - Session & Window Management

Effortlessly manage tmux sessions and open new windows with flexibility.

This script automates launching and managing tmux sessions and windows, offering flexibility and convenience.

## Features

* **Automatic session creation:** Identifies existing "main" session or creates a new one named "main".
* **Named session groups:** Launch new sessions within grouped windows for better organization.
* **Flexible window opening:** Select between opening a new session or attaching to the last one.
* **Commented-out options:** Customize default behavior for advanced users.

## Requirements

* tmux installed on your system.

## Usage

1. Save the script as `tmux-launcher.bash`.
2. Make it executable: `chmod -c u+x tmux-launcher.bash`.
3. Place it in your `$PATH` directory.
4. Source `tmux-launcher.bash` from your `.bashrc`.

```bash
curl -fSLROJ 'https://github.com/CodeIter/tmux-launch.bash/raw/main/tmux-launch.bash'
chmod -c u+x tmux-launcher.bash
mkdir -vp ~/.local/bin
mv -fv tmux-launcher.bash ~/.local/bin
echo -e '\nsource ~/.local/bin/tmux-launcher.bash\n' >> ~/.bashrc
```

## Behavior

- A main session possible names in this order: "main" "default" "master" "0".
- A session group is named: <session_name>_grp
- If a main session exists, opens a new window within its corresponding group.
- If no main session exists, creates a new session named "main" and opens a new window.
- You can customize behavior by uncommenting relevant sections in the script.

## Advanced Options

- Uncomment the `_tmux_win_nbre` section to open a new window in the existing "main" session.
- Uncomment the `tmux list-sessions` section to attach to the last session instead of opening a new one.

## Note

This script setup GnuPG agent by setting `export GPG_TTY=$(tty)` to enable gpg 's pine try inside Tmux.
See Solved Arch forum thread [pinentry password prompt broken inside tmux sessions](https://bbs.archlinux.org/viewtopic.php?id=262296)
Solution at [post](https://bbs.archlinux.org/viewtopic.php?pid=1947361#p1947361)

## Additional Information

* This is a basic implementation with room for customization.
* Refer to the script comments for further configuration options.
* Feel free to contribute modifications or improvements via pull requests.

Enjoy streamlined tmux session management with this launcher!

## License

This project is licensed under the terms of the **MIT** License.


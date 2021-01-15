# Better time output from coreutils:
export TIME_STYLE="long-iso"

# Sane man page width:
export MANWIDTH=80

# Sane less with: smart case search, quit if less than one screen, skip
# clearing screen, and display colors:
export LESS=-iFXR
export PAGER=less

# Use custom readline(3) inputrc:
export INPUTRC=/etc/input.local.rc

# Append ~/.local/bin if it exists:
[ -d ~/.local/bin ] && append_path ~/.local/bin

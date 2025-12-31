# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Custom Tool: Convert video for WhatsApp
wa-convert() {
    # Check if input file is provided
    if [ -z "$1" ]; then
        echo "Usage: wa-convert <filename>"
        return 1
    fi

    # Run ffmpeg
    # ${1%.*} removes the old extension so we can add "-wa.mp4"
    ffmpeg -i "$1" \
        -c:v libx264 -pix_fmt yuv420p -crf 23 \
        -c:a aac -b:a 128k \
        "${1%.*}-wa.mp4"
}

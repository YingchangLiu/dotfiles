# Set language to English if in graphical environment
if [[ -n "$DISPLAY" ]]; then
    if [[ "$TERM" =~ xterm ]]; then
        export LANG=en_US.UTF-8
        # A English locale is required for some programs to work properly.
        # When in Chinese locale, terminal may not display some characters correctly.
        # export LC_ALL=en_US.UTF-8
    fi
fi
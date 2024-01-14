export NNN_FIFO=/tmp/nnn.fifo
export TMPDIR=/tmp

export NNN_BMS='h:~/;d:~/Downloads;s:~/dotfile'
export NNN_ARCHIVE="\\.(7z|bz|bz2|gz|rar|rpm|tar|tgz|zip)$"
NNN_PLUG_DEFAULT='b:boom;p:preview-tui;j:autojump;v:imgview;t:nmount;d:diffs;f:finder'
NNN_PLUG_INLINE='E:!go run "$nnn"*'
NNN_PLUG="$NNN_PLUG_DEFAULT;$NNN_PLUG_INLINE"
export NNN_PLUG


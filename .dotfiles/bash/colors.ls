core {
fi=0;39  #normal file
di=1;95  #directory
ln=1;35  #symbolic link
so=1;31  #socket
pi=1;33  #pipe
ex=1;92  #executable
bd=0;34  #block device/block special
cd=0;34  #character device/character special
su=0;42  #setuid executable
sg=0;102  #setgid executable
tw=0;32  #directory with sticky bit
ow=0;33  #directory without sticky bit
or=0;41;30  #orphan
}

images (1;31) {
*.jpg
*.JPG
*.jpeg
*.png
*.gif
*.bmp
*.tiff
*.TIFF
*.cdr
*.go
*.ico
*.svg
}

video (1;33) {
*.avi
*.divx
*.IFO
*.m2v
*.m4v
*.mkv
*.MOV
*.mov
*.mp4
*.mpeg
*.mpg
*.ogm
*.wmv
}

audio (1;32) {
*.aac
*.m4a
*.mid
*.midi
*.mp3
*.oga
*.ogg
*.flac
*.alac
*.wav
}

archives (0;35) {
*.7z
*.rar
*.tar
*.tgz
*.zip
}

programming (0;36) {
*.c
*.h
*.cpp
*.java
*.class=1;34
}


#!/bin/zsh

# independent of non-loging shell, depend on xserver
dunst &
setxkbmap -layout us,ara -option grp:alt_space_toggle -option ctrl:swapcaps
slstatus &> /dev/null &
cbatticon &> /dev/null &
setbg $HOME/pics/wallpapers &> /dev/null &
sxhkd &> /dev/null &
safeeyes &> /dev/null &
# picom &
# X

sysresources=/etc/X11/xinit/.Xresources
userresources=$HOME/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
usermodmap=$HOME/.Xmodmap

[ -f $sysresources ] && xrdb -merge $sysresources
[ -f "$userresources" ] && xrdb -merge "$userresources"
# needs to be after setxkbmap
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f "$usermodmap" ] && xmodmap "$usermodmap"
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ]   && . ~/.xprofile


# # start some nice programs
# if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#   [ -x "$f" ] && . "$f"
#  done
#  unset f
# fi


exec dwm > .dwm.log

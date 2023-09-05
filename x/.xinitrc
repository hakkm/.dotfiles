#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && . /etc/xprofile
[[ -f ~/.xprofile ]] && . ~/.xprofile
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# for dwm : Bind the right Alt key to Mod4
# xmodmap -e "keycode 135 = Super_R"  # reassign Alt_R to Super_L
# xmodmap -e "keycode 135 = Super_L"  # reassign Alt_R to Super_L
# xmodmap -e "remove mod1 = Super_L"  # make sure X keeps it out of the mod1 group





# If not running interactively, don't do anything
#[[ $- != *i* ]] && return

alias ls='ls  --color=auto'
alias la='ls -lah --color=always'
alias li='ls -hlia --color=always'
alias l.='ls .[!.]* --color=always'
alias ..='cd ..'
alias b='cd -'
alias c='clear'
#PS1='[\u@\h \W]\$ '

countdown(){
    date1=$((`date +%s` + $1));
    while [ "$date1" -ge `date +%s` ]; do 
        ## Is this more than 24h away?
        days=$(($(($(( $date1 - $(date +%s))) * 1 ))/86400))
        echo -ne "$days day(s) and $(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r"; 
        sleep 0.1
        done
    }
stopwatch(){
    date1=`date +%s`; 
    while true; do 
        days=$(( $(($(date +%s) - date1)) / 86400 ))
        echo -ne "$days day(s) and $(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
        sleep 0.1
        done
    }

#!/usr/bin/env bash
#
# Edited and abbreviated version of "ANSI code generator"
#
# © Copyright 2015 Tyler Akins
# Licensed under the MIT license with an additional non-advertising clause
# See http://github.com/fidian/ansi

color_table() {
    local FNB_LOWER FNB_UPPER PADDED

    FNB_LOWER="$(colorize 2 22 f)n$(colorize 1 22 b)"
    FNB_UPPER="$(colorize 2 22 F)N$(colorize 1 22 B)"
    echo -n "bold $(colorize 1 22 Sample)               "
    echo -n "faint $(colorize 2 22 Sample)              "
    echo "italic $(colorize 3 23 Sample)"
    echo -n "underline $(colorize 4 24 Sample)          "
    echo -n "blink $(colorize 5 25 Sample)              "
    echo "inverse $(colorize 7 27 Sample)"
    echo "invisible $(colorize 8 28 Sample)"
    echo -n "strike $(colorize 9 29 Sample)             "
    echo -n "fraktur $(colorize 20 23 Sample)            "
    echo "double-underline $(colorize 21 24 Sample)"
    echo -n "frame $(colorize 51 54 Sample)              "
    echo -n "encircle $(colorize 52 54 Sample)           "
    echo "overline $(colorize 53 55 Sample)"
    echo ""
    echo "             black   red     green   yellow  blue    magenta cyan    white"
    for BG in 40:black 41:red 42:green 43:yellow 44:blue 45:magenta 46:cyan 47:white; do
        PADDED="bg-${BG:3}           "
        PADDED="${PADDED:0:13}"
        echo -n "$PADDED"
        for FG in 30 31 32 33 34 35 36 37; do
            echo -n "$CSI${BG:0:2};${FG}m"
            echo -n "$FNB_LOWER"
            echo -n "$CSI$(( $FG + 60 ))m"
            echo -n "$FNB_UPPER"
            echo -n "${CSI}0m  "
        done
        echo ""
        echo -n "  +intense   "
        for FG in 30 31 32 33 34 35 36 37; do
            echo -n "$CSI$(( ${BG:0:2} + 60 ));${FG}m"
            echo -n "$FNB_LOWER"
            echo -n "$CSI$(( $FG + 60 ))m"
            echo -n "$FNB_UPPER"
            echo -n "${CSI}0m  "
        done
        echo ""
    done
    echo ""
    echo "Legend:"
    echo "    Normal color:  f = faint, n = normal, b = bold."
    echo "    Intense color:  F = faint, N = normal, B = bold."
}

colorize() {
    echo -n "$CSI${1}m$3$CSI${2}m"
}

# Handle long options until we hit an unrecognized thing
CONTINUE=true
RESTORE=true
NEWLINE=false
ESCAPE=false
ESC="$(echo -e '\033')"
CSI="${ESC}["
OSC="${ESC}]"
ST="${ESC}\\"
OUTPUT=""
SUFFIX=""


telltime() {
    while [ 1 ] ; do echo -en
            (date +%T | figlet); sleep 1; 
            for i in 1 2 3 4 5 6
    do 
                   printf "\x1b[A\x1b[2K";
                   let i--
    done
    done
}

#Entry Sequence
clear
#neofetch
PS1="\[\033[s\033[0;118H\033[0;44m\033[1;33m\d\033[0;40m:\033[0;41m\033[k\033[1;33m\t\033[0m\033[u\]\[\033[1;37m\]<\u@\h \w>\$ \[\033[0m\]"
export PS1
#Export PAgER="most"

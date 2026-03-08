#!/usr/bin/env bash

if [ -f /etc/os-release ]; then
    . /etc/os-release
    case $ID in
        nixos)
            echo "" 
            ;;
        fedora)
            echo ""  
            ;;
        arch|endeavouros|manjaro)
            echo "" 
            ;;
        ubuntu|debian|pop|linuxmint)
            echo ""  
            ;;
        *)
            echo ""  
            ;;
    esac
else
    echo ""  
fi

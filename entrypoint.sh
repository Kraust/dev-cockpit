#!/usr/bin/env bash

OPT_DIR=/opt
HOME_DIR=$HOME

mkdir -p "$HOME_DIR/.config"

TO_COPY=$(cat "$OPT_DIR"/.to-copy)
for item in "${TO_COPY[@]}"; do
	if [ ! -d "$HOME_DIR/$item" ] ||
		[ ! -f "$HOME_DIR/$item" ] ||
		[ ! -L "$HOME_DIR/$item" ]; then
		echo "Copying $item"
		cp "$OPT_DIR/$item" "$HOME_DIR/$item"
	fi
done

nvim --headless --listen 0.0.0.0:9999

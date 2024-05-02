#!/bin/sh

CONF_DIR=docker/nginx/conf/conf.d
TMP_DIR=docker/nginx/conf/example-tmp
TMP_CONF_FIlE="$TMP_DIR"/host.conf.tmp

if [ ! -d "$CONF_DIR" ] || [ ! -f "$CONF_DIR/$1.conf" ]; then
  if [ -d "$CONF_DIR" ]; then
      rm -Rf "$CONF_DIR"
  fi

  reg='$(HOST)'
  mkdir "$CONF_DIR"

  if [ -f "$TMP_DIR/default.conf" ]; then
    cp "$TMP_DIR/default.conf" "$CONF_DIR/default.conf"
  fi

  sed "s/$reg/$1/g" "$TMP_CONF_FIlE" > "$CONF_DIR/$1.conf"
fi
#!/bin/sh

# Run custom scripts
scripts_dir="${SCRIPTS_DIR:-/var/www/html/scripts}"
if [ -d "$scripts_dir" ]; then
  if [ -z "$SKIP_CHMOD" ]; then
    # make scripts executable in case they aren't
    chmod -Rf 750 $scripts_dir; sync;
  fi
  # run scripts in number order
  for i in `ls $scripts_dir`; do $scripts_dir/$i ; done
else
  echo "Can't find script directory"
fi

# Start supervisord and services
exec /usr/bin/supervisord -n -c /etc/supervisord.conf

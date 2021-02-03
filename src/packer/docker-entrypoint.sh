#!/usr/bin/env bash
set -e

# =========================================================
# This is an example entrypoint script
# - You should preferably run containers as non-root user
# - Containers should work like a program, with optional
#   inputs (i.e. validate your inputs/CMD)
# =========================================================
printf "Image: $(cat /etc/issue.net)\n"

# VALIDATE CONTAINER CMD
if [ "${1}" = 'cmd' ]; then
  shift
  set -- bash -c "${@}"
elif [ "${1}" = 'show' ]; then
  set -- echo "Your command: ${@}"
else
  set -- echo "Valid inputs are: cmd, show"
fi

# CHECK ENVIRONMENT VARIABLES
if [ -z ${GOSU} ]; then
  printf "[WARNING] Running as: root\n"
  printf "  - Set 'GOSU' variable to run unprivileged\n"
  printf "  - Set 'GOSU_USER' to override default username\n"
else
  USERNAME=${GOSU_USER:-groot}
  useradd ${USERNAME}
  set -- gosu ${USERNAME} "${@}"
fi

# EXECUTE
exec "${@}"

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
case "${1}" in
  'hello')
    set -- echo "Hello!"
    ;;

  'show')
    set -- echo "Your command(s): ${@}"
    ;;

  'cmd')
    shift
    ;;

  *)
    printf "\nValid inputs:\n"
    printf "  hello  -> (default) Says hello\n"
    printf "  show * -> Prints your input to stdout\n\n"
    printf "  cmd    -> Runs command in bash\n\n"
    printf "Any other command will print this message\n"
    exit 0
   ;;
esac

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

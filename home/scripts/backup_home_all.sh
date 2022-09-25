#!/bin/bash

# colors def for printf
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# backup dir definition
BACKUP_DIR='/home/nomis/backups/home'

# exclude list for 'du' and 'tar' command
EXCLUDE=(\
    "$BACKUP_DIR/*" \
    "/home/nomis/.local/share/Trash/*" \
    "/home/nomis/.local/share/MY_GL_CACHE/*" \
    "/home/nomis/.nv/GLCache/*" \
    "/home/nomis/Public/*" \
)

# build the '--exclude' param
EXCLUDE_OPTIONS=()
for x in "${EXCLUDE[@]}"; do
  EXCLUDE_OPTIONS+=(--exclude="$x")
done

# estimate backup size
ESTIMATE_BACKUP_SIZE=$(\
    du -hs \
        /home/nomis \
        "${EXCLUDE_OPTIONS[@]}" \
        | tail -n 1 \
        | head -n 1 \
        | awk '{print $1;}'\
)
ESTIMATE_BACKUP_SIZE="$ESTIMATE_BACKUP_SIZE$(echo 'B')"

# ask for user
printf "\n"
printf "${YELLOW} --> estimated size of backup: $ESTIMATE_BACKUP_SIZE ${NC}\n"
printf "${YELLOW} --> Are you sure? [y/N]: ${NC}"
read -r response

# check user response and backup
if [[ $response == "y" || $response == "Y" ]]; then
    TODAY=`date '+%Y_%m_%d_%s'`
    BACKUP_TYPE='home-all'

    # create backup folder if no exist
    mkdir -p $BACKUP_DIR

    # backup here as sudoer
    sudo tar -czvf \
        $BACKUP_DIR/backup_$BACKUP_TYPE\_$TODAY.tar.gz \
        "${EXCLUDE_OPTIONS[@]}" \
        /home/nomis
    printf "\n${GREEN}backup: OK${NC}\n"
    exit 1
else
    printf "\n${RED}ABORT !${NC}\n"
    exit 0
fi

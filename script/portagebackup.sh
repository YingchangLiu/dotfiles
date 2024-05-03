#!/bin/bash
# Backup portage configuration
rsync -av  --exclude 'gnupg' /etc/portage/*  ~/dotfile/etc/portage/
rsync -av /var/lib/portage/world* ~/dotfile/var/lib/portage/
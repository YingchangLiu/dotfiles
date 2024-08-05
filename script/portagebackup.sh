#!/bin/bash
# Backup portage configuration
rsync -av  --exclude 'gnupg' /etc/portage/*  ~/dotfile/extra/gentoo_portage/etc/portage/
rsync -av /var/lib/portage/world* ~/dotfile/extra/gentoo_portage/var/lib/portage/
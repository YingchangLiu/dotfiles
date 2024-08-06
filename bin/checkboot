#!/bin/bash

# get all kernels in /boot
get_boot_kernels() {
    local kernels=()
    for kernel in /boot/vmlinuz*; do
        local version=$(file $kernel | grep -oP 'version \K[^ ]+')
        kernels+=("$version")
    done
    echo "${kernels[@]}"
}

# get the latest kernel in /boot
get_latest_kernel() {
    local latest_version=""
    for kernel in /boot/vmlinuz*; do
        local version=$(file $kernel | grep -oP 'version \K[^ ]+')
        if [[ "$version" > "$latest_version" ]]; then
            latest_version=$version
        fi
    done
    echo $latest_version
}

rc=1

# check if any deleted libraries are still in use
libs=$(lsof -n +c 0 2> /dev/null | grep 'DEL.*lib' | awk '1 { print $1 ": " $NF }' | sort -u)
if [[ -n $libs ]]; then
    cat <<< $libs
    echo "# LIBS: (QAQ) re-login required. Some deleted libraries in use"
    rc=0
else
    echo "# LIBS: (๑•̀ㅂ•́)و✧ No deleted libraries in use"
fi

active_kernel=$(uname -r)
boot_kernels=($(get_boot_kernels))
latest_kernel=$(get_latest_kernel)
kernel_matched=0

# check if the current running kernel is in the list of kernels in /boot
for kernel_version in "${boot_kernels[@]}"; do
    if [[ "$active_kernel" == *"$kernel_version"* ]]; then
        kernel_matched=1
        break
    fi
done

if [[ $kernel_matched -eq 0 ]]; then
    echo "# KERNEL: Current running kernel does not match any in /boot"
    rc=0
fi

# check if the current running kernel is the latest kernel in /boot,
# if not, you can reboot to use the latest kernel
if [[ "$active_kernel" != *"$latest_kernel"* ]]; then
    echo "Current running kernel: $active_kernel"
    echo "Latest kernel in /boot: $latest_kernel"
    echo "# KERNEL: (°ー°〃) Newer kernel available"
    rc=0
else
    echo "# KERNEL: (๑•̀ㅂ•́)و✧ No reboot required, running the latest kernel: $active_kernel "
fi

exit $rc

#!/bin/sh
VM_NAME=$1
/usr/local/bin/multipass delete $VM_NAME
/usr/local/bin/multipass purge
/usr/bin/ssh-keygen -R $VM_NAME.local
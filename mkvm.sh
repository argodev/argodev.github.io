#!/bin/sh

# hattip to https://medium.com/@ahmadb/using-multipass-with-cloud-init-bc4b92ad27d9

VM_NAME=$1
multipass launch -n $VM_NAME --disk 10G --cloud-init ./cloud-config.yaml
multipass mount . $VM_NAME:/site
ssh ubuntu@$VM_NAME.local


#multipass launch lts --name ltsInstance --mem 2G --disk 10G --cpus 2
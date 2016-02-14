#!/bin/bash

# Creates a virtual machine on a machine

# Environment variables
DTD_VM_NAME=dtd2016
DTD_VM_BASE=$HOME
DTD_VM_DIR=$DTD_VM_BASE/$DTD_VM_NAME
DTD_VM_ISO=dtd2016-desktop.iso

dtd_vm_chks () {
  # Check if Virtualbox is installed.
  command -v vboxmanage >/dev/null 2>&1 || { echo "This script requires Virutalbox but it's not installed.  Aborting." >&2; exit 1; }

  # Check if the virtualmachine does not exist already.
  vmexists=$(vboxmanage list vms | grep $DTD_VM_NAME)
  if [[ $vmexists == *"dtd2016"* ]]
  then
    echo "The machine $DTD_VM_NAME already exists. Aborting."
    exit
  fi

  # Check disk image
  if [[ ! -f ../../$DTD_VM_ISO ]]
  then
    if [[ ! -f $DTD_VM_BASE/$DTD_VM_NAME/$DTD_VM_ISO ]]
    then
      echo "Missing the file $DTD_VM_ISO. You can copy it to $DTD_VM_BASE/$DTD_VM_NAME and rerun this script."
      exit
    fi
  fi
}

dtd_vm_prep () {
  # Copy iso file
  # cp ../iso/dtd2016-desktop.iso $dtd-vm-dir
  # Check for a hostonly network
  networks=$(vboxmanage list hostonlyifs | grep "vboxnet")
  if [[ $networks != *"vboxnet"* ]]
  then
    vboxmanage hostonlyif create;
  fi

}

dtd_vm_create () {
  # Create the bare vm
  vboxmanage createvm --name $DTD_VM_NAME --basefolder $DTD_VM_BASE/ --ostype Ubuntu --register
  vboxmanage modifyvm $DTD_VM_NAME --pae on
  # Memory
  vboxmanage modifyvm $DTD_VM_NAME --memory 768 --vram 24
  # Network
  vboxmanage modifyvm $DTD_VM_NAME --nic1 hostonly
  vboxmanage modifyvm $DTD_VM_NAME --hostonlyadapter1 vboxnet0
  # Clipboard
  vboxmanage modifyvm $DTD_VM_NAME --clipboard bidirectional

  # Add a sata disk controller
  vboxmanage storagectl $DTD_VM_NAME --name SATA --add sata
  # Create an 8GB disk file
  vboxmanage createhd --filename $DTD_VM_DIR/$DTD_VM_NAME --size 8192
  # Attach the disk to the sata controller
  vboxmanage storageattach $DTD_VM_NAME --storagectl SATA --medium $DTD_VM_DIR/$DTD_VM_NAME.vdi --port 0 --type hdd

  # Add an IDE controller
  vboxmanage storagectl $DTD_VM_NAME --name IDE --add ide
  # Copy over the iso file
  # cp ../iso/dtd2016-desktop.iso $dtd-vm-dir
  cp ../../$DTD_VM_ISO $DTD_VM_DIR
  # Attach the iso file as an optical disk
  vboxmanage storageattach $DTD_VM_NAME --storagectl IDE --medium $DTD_VM_DIR/$DTD_VM_ISO --port 0 --type dvddrive --device 1
}

dtd_vm_install() {
  # Start the vm.
  vboxmanage startvm $DTD_VM_NAME
  sleep 5
  # Down arrow.
  # vboxmanage controlvm $DTD_VM_NAME keyboardputscancode 50 d0
  # vboxmanage controlvm $DTD_VM_NAME keyboardputscancode 50 d0
  # Hit the enter key.
  vboxmanage controlvm $DTD_VM_NAME keyboardputscancode 1c 9c
}

# First perform some checks
dtd_vm_chks;
# Then prepare the environment.
dtd_vm_prep;
# Create the vm
dtd_vm_create
# Install the OS from the iso
dtd_vm_install;

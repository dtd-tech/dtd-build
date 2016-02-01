#!/bin/bash

# Creates a virtual machine on a machine

# Environment variables
DTD_VM_NAME=dtd2016
DTD_VM_BASE=$HOME
DTD_VM_DIR=$DTD_VM_BASE/$DTD_VM_NAME
DTD_VM_ISO=dtd2016-desktop.iso

dtd_vm_chks () {
  # Check if Virtualbox is installed.
  Echo "All ok"
  # Check if the virtualmachine does not exist already.

  # Check for disk space

  # Check if we're being run from the usb stick.
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
  cp ~/dtd/beta1/$DTD_VM_ISO $DTD_VM_DIR
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

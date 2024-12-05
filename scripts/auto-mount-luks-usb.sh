#!/bin/bash
# Automatically unlock and mount a LUKS-encrypted USB drive.

# Usage: ./auto-mount-luks-usb.sh <device> <mount_point> <key_file>

# Check if the required arguments are provided.
if [[ $# -lt 3 ]]; then
  echo "Usage: $0 <device> <mount_point> <key_file>"
  exit 1
fi

DEVICE=$1
MOUNT_POINT=$2
KEY_FILE=$3
MAPPER_NAME="luks_usb"

# Check if the device exists.
if [[ ! -b "$DEVICE" ]]; then
  echo "Error: Device $DEVICE does not exist."
  exit 1
fi

# Check if the key file exists.
if [[ ! -f "$KEY_FILE" ]]; then
  echo "Error: Key file $KEY_FILE does not exist."
  exit 1
fi

# Create the mount point directory if it doesn't exist.
if [[ ! -d "$MOUNT_POINT" ]]; then
  echo "Creating mount point $MOUNT_POINT..."
  sudo mkdir -p "$MOUNT_POINT"
fi

# Unlock the LUKS device.
echo "Unlocking LUKS device $DEVICE..."
sudo cryptsetup luksOpen --key-file "$KEY_FILE" "$DEVICE" "$MAPPER_NAME"
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to unlock LUKS device $DEVICE."
  exit 1
fi

# Mount the unlocked device.
echo "Mounting /dev/mapper/$MAPPER_NAME to $MOUNT_POINT..."
sudo mount /dev/mapper/"$MAPPER_NAME" "$MOUNT_POINT"
if [[ $? -eq 0 ]]; then
  echo "Successfully mounted /dev/mapper/$MAPPER_NAME to $MOUNT_POINT."
else
  echo "Error: Failed to mount /dev/mapper/$MAPPER_NAME."
  sudo cryptsetup luksClose "$MAPPER_NAME"
  exit 1
fi

# Provide unmount instructions.
echo "To unmount and lock the device, run the following commands:"
echo "sudo umount $MOUNT_POINT"
echo "sudo cryptsetup luksClose $MAPPER_NAME"

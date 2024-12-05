#!/bin/bash
# Bulk encrypt files in a specified directory using GPG.

# Usage: ./encrypt-files.sh <directory> <recipient_email>

# Check if the required arguments are provided.
if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <directory> <recipient_email>"
  exit 1
fi

DIRECTORY=$1
RECIPIENT=$2

# Check if the directory exists.
if [[ ! -d "$DIRECTORY" ]]; then
  echo "Error: Directory $DIRECTORY does not exist."
  exit 1
fi

# Encrypt each file in the directory.
for file in "$DIRECTORY"/*; do
  if [[ -f "$file" ]]; then
    echo "Encrypting $file..."
    gpg --encrypt --recipient "$RECIPIENT" "$file"
    if [[ $? -eq 0 ]]; then
      echo "Successfully encrypted $file to $file.gpg"
    else
      echo "Failed to encrypt $file"
    fi
  fi
done

echo "Encryption process completed for all files in $DIRECTORY."

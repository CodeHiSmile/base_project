#!/bin/bash

# Check if screen name was passed as argument
if [ -z "$1" ]; then
  # If not, prompt for it interactively
  read -p "👉 Enter screen name: " SCREEN_NAME
else
  SCREEN_NAME=$1
fi

# Confirm value
echo ""
echo "✅ Creating screen brick with name: $SCREEN_NAME"
echo ""

# Run mason make command
mason make screen_brick --name "$SCREEN_NAME"

echo ""
echo "✅ Done."

dart run build_runner build  --delete-conflicting-outputs
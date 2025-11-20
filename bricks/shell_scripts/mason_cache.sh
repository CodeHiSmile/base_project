#!/bin/bash

# Function to show cache path
show_cache_path() {
  echo "📂 Mason cache directory:"
  mason cache-dir
}

# Function to list cached bricks
list_cache() {
  echo ""
  echo "📦 Cached bricks:"
  mason list
}

# Function to clean cache
clean_cache() {
  echo ""
  read -p "⚠️ Are you sure you want to clear the Mason cache? (y/n): " confirm
  if [[ $confirm == [yY] ]]; then
    mason cache clear
    echo "✅ Mason cache cleared."
  else
    echo "❌ Cancelled."
  fi
}

# Menu
echo "📦 Mason Cache Manager"
echo "1️⃣ Show cache path"
echo "2️⃣ List cached bricks"
echo "3️⃣ Clear cache"
echo "0️⃣ Exit"
echo ""

read -p "👉 Select an option (0-3): " option

case $option in
  1)
    show_cache_path
    ;;
  2)
    list_cache
    ;;
  3)
    clean_cache
    ;;
  0)
    echo "👋 Bye."
    exit 0
    ;;
  *)
    echo "❌ Invalid option."
    ;;
esac

#!/bin/bash

# Prompt for inputs if not passed as arguments
if [ -z "$1" ]; then
  read -p "👉 Enter feature name: " FEATURE_NAME
else
  FEATURE_NAME=$1
fi

if [ -z "$2" ]; then
  read -p "👉 Enter action type: " ACTION_TYPE
else
  ACTION_TYPE=$2
fi

if [ -z "$3" ]; then
  read -p "👉 Enter entity name: " ENTITY_NAME
else
  ENTITY_NAME=$3
fi

if [ -z "$4" ]; then
  read -p "👉 Enter path value: " PATH_VALUE
else
  PATH_VALUE=$4
fi

if [ -z "$5" ]; then
  read -p "👉 Enter method value: " METHOD_VALUE
else
  METHOD_VALUE=$5
fi

if [ -z "$6" ]; then
  read -p "👉 Enter screen name: " SCREEN_NAME
else
  SCREEN_NAME=$6
fi
if [ -z "$7" ]; then
  read -p "👉 Enter repository name: " REPO_NAME
else
  REPO_NAME=$7
fi

# Confirm values before running commands
echo ""
echo "✅ Summary:"
echo "Feature Name : $FEATURE_NAME"
echo "Action Type  : $ACTION_TYPE"
echo "Entity Name  : $ENTITY_NAME"
echo "Path Value   : $PATH_VALUE"
echo "Method Value : $METHOD_VALUE"
echo "Screen Name  : $SCREEN_NAME"
echo ""

read -p "Proceed with these values? (y/n): " confirm
if [[ $confirm != [yY] ]]; then
  echo "❌ Cancelled."
  exit 1
fi

# Making screen brick
echo "📦 Making screen brick..."
cd lib/presentation/features || { echo "❌ Failed to change directory to lib/src/ui"; exit 1; }
mason make screen_brick --name "$SCREEN_NAME"
cd ../../..

# Making domain brick
echo "📦 Making domain brick..."
#cd ../domain || { echo "❌ Failed to change directory to domain"; exit 1; }
mason make domain_brick \
  --feature_name "$FEATURE_NAME" \
  --action_type "$ACTION_TYPE" \
  --entity_name "$ENTITY_NAME" \


# Making data brick
echo "📦 Making data brick..."
#cd ../data || { echo "❌ Failed to change directory to modules/data"; exit 1; }
mason make data_brick \
  --feature_name "$FEATURE_NAME" \
  --path "$PATH_VALUE" \
  --entity_name "$ENTITY_NAME" \
  --method "$METHOD_VALUE"\

# Return to project root
#cd ../..

echo ""
echo "✅ All bricks generated successfully."

dart run build_runner build  --delete-conflicting-outputs

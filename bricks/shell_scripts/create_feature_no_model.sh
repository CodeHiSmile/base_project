#!/bin/bash

# Prompt for inputs step by step
echo "👉 Enter feature name:"
read FEATURE_NAME

echo "👉 Enter action type:"
read ACTION_TYPE

echo "👉 Enter entity name:"
read ENTITY_NAME

echo "👉 Enter repository name:"
read REPO_NAME

echo "👉 Enter path value:"
read PATH_VALUE

echo "👉 Enter method value:"
read METHOD_VALUE

# Confirm values
echo ""
echo "✅ Summary:"
echo "Feature Name: $FEATURE_NAME"
echo "Action Type: $ACTION_TYPE"
echo "Entity Name: $ENTITY_NAME"
echo "Path Value: $PATH_VALUE"
echo "Method Value: $METHOD_VALUE"
echo ""

# Confirm before proceeding
read -p "Proceed with these values? (y/n) " confirm
if [[ $confirm != [yY] ]]; then
  echo "❌ Cancelled."
  exit 1
fi

# Run your mason make commands
echo "🔨 Making domain brick..."
cd modules/domain || exit
mason make aeh_domain_no_model_brick \
  --feature_name "$FEATURE_NAME" \
  --action_type "$ACTION_TYPE" \
  --entity_name "$ENTITY_NAME"
\
cd ../data || exit
echo "🔨 Making data brick..."
mason make aeh_data_no_model_brick \
  --feature_name "$FEATURE_NAME" \
  --path "$PATH_VALUE" \
  --entity_name "$ENTITY_NAME" \
  --method "$METHOD_VALUE"\
  --action_type "$ACTION_TYPE"

cd ../..

echo "✅ All done."

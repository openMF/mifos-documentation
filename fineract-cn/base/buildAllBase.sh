#!/bin/bash

source ../env.sh

echo ""
echo "Building base libraries..."
echo ""

directories=(
    "fineract-cn-crypto"
)

if [ "$CLONE_REPOSITORIES" = "true"  ]; then
  for i in "${directories[@]}"; do
    echo ""
    echo "Cloning $i..."
    echo ""
    git clone https://github.com/apache/$i
  done
fi

for i in "${directories[@]}"; do
  echo ""
  echo "Building $i base library..."
  echo ""
  cd $i
  chmod +x gradlew
  ./gradlew publishToMavenLocal
  cd ..
done

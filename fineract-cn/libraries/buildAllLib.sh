#!/bin/bash

source ../env.sh

echo ""
echo "Building libraries..."
echo ""

directories=(
    "fineract-cn-anubis"
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
  echo "Building $i library..."
  echo ""
  cd $i
  chmod +x gradlew
  ./gradlew publishToMavenLocal
  cd ..
done

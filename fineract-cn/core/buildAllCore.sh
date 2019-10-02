#!/bin/bash

source ../env.sh

echo ""
echo "Building core libraries..."
echo ""

directories=(
    "fineract-cn-lang"
    "fineract-cn-api"
    "fineract-cn-async"
    "fineract-cn-cassandra"
    "fineract-cn-mariadb"
    "fineract-cn-postgresql"
    "fineract-cn-data-jpa"
    "fineract-cn-command"
    "fineract-cn-test"
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
  echo "Building $i core library..."
  echo ""
  cd $i
  chmod +x gradlew
  ./gradlew publishToMavenLocal
  cd ..
done

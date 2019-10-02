#!/bin/bash
deployment_jars="../deployment/jars"

source ../env.sh

echo ""
echo "Building integrations tests..."
echo ""

directories=(
    "fineract-cn-default-setup"
    "fineract-cn-service-starter"
    "fineract-cn-deploy-server"
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
  echo "Building $i test ..."
  echo ""
  cd $i
  chmod +x gradlew
  ./gradlew publishToMavenLocal
  cd ..
done

# Eureka and Spring cloud config
service="fineract-cn-deploy-server"
echo ""
echo "Building $service service..."
echo ""
cd $service
chmod +x gradlew
./gradlew build
cd ..
if [ -d "$service/build/libs" ]; then
    echo "Copy runnable jar to deployment jars directory..."
    if [ ! -d "$deployment_jars/$service" ]; then
        mkdir -p $deployment_jars/$service
    fi
    cp -f $service/build/libs/*.jar $deployment_jars/$service/
fi

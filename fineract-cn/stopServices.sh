#!/usr/bin/env bash

if [ ! -f "envServices.sh" ]; then
    echo "Can't start services. envServices.sh not found."
    exit 1
fi

. envServices.sh

echo "Stopping Services..."
echo ""

for i in "${service_directories[@]}"; do
    echo ""
    echo "Stopping $i service ..."
    echo ""

    kill -9 `cat /tmp/$i.pid`
    rm /tmp/$i.pid
done

echo ""
echo "Stopping Eureka service ..."
echo ""

kill -9 `cat /tmp/fineract-cn-eureka.pid`
rm /tmp/fineract-cn-eureka.pid

echo "Done."
echo ""
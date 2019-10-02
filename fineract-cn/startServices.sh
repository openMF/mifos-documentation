#!/usr/bin/env bash

if [ ! -f "envServices.sh" ]; then
    echo "Can't start services. envServices.sh not found."
    exit 1
fi

if [ -f nohup.out ]; then
    backup_date=`date +'%Y-%m-%d'`
    mv nohup.out nohup_$backup_date.bak
fi

. envServices.sh

echo "Start Eureka..."
nohup java -Xmx$XMX_OPT_EUREKA \
    -Dspring.cloud.config.server.native.searchLocations=file://$EUREKA_CONFIG_PATH \
    -jar jars/eureka-service/service-0.1.0-BUILD-SNAPSHOT-boot.jar 2>&1 &
    echo "pid: " $!
    echo $! > /tmp/fineract-cn-eureka.pid

echo "Waiting for Eureka..."
sleep 30

echo ""
echo "Starting Services..."
for i in "${service_directories[@]}"; do
    echo ""
    echo "Starting $i service ..."

    nohup java -Xmx$XMX_OPT_SVC -jar jars/$i/service-0.1.0-BUILD-SNAPSHOT-boot.jar 2>&1 &
    echo $! > /tmp/$i.pid
    echo "pid: " $!
done

echo "Done."
echo ""
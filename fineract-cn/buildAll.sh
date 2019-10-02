#!/bin/bash

echo ""
./cleanPackageRepository.sh
echo ""

cd base
./buildAllBase.sh
cd ..


cd core
./buildAllCore.sh
cd ..

cd libraries
./buildAllLib.sh
cd ..


cd services
./buildAllService.sh
cd ..


cd integration-tests
./buildAllTest.sh
cd ..

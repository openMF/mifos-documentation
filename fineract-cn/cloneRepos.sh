#!/bin/bash

echo ""
echo "Cloning repositories..."
echo ""

directories=(
    "fineract-cn-crypto"
    "fineract-cn-lang"
    "fineract-cn-api"
    "fineract-cn-async"
    "fineract-cn-cassandra"
    "fineract-cn-mariadb"
    "fineract-cn-data-jpa"
    "fineract-cn-command"
    "fineract-cn-test"
    "fineract-cn-anubis"
    "fineract-cn-identity"
    "fineract-cn-permitted-feign-client"
    "fineract-cn-provisioner"
    "fineract-cn-rhythm"
    "fineract-cn-template"
    "fineract-cn-office"
    "fineract-cn-customer"
    "fineract-cn-group"
    "fineract-cn-accounting"
    "fineract-cn-portfolio"
    "fineract-cn-deposit-account-management"
    "fineract-cn-cheques"
    "fineract-cn-payroll"
    "fineract-cn-teller"
    "fineract-cn-reporting"
    "fineract-cn-notifications"
    "fineract-cn-interoperation"
    "fineract-cn-default-setup"
    "fineract-cn-service-starter"
    "fineract-cn-deploy-server"
    "fineract-cn-postgreqsql"
)

for i in "${directories[@]}"; do
  echo ""
  echo "Cloning $i..."
  echo ""
  git clone https://github.com/apache/$i
done

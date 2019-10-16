UPDATE BANKS
SET PAYMENTS_URL='https://api.lion.mifos.io:8243/open-banking/v3.1/pisp/v3.1.2'
WHERE SHORTNAME = 'Lion';

UPDATE BANKS
SET PAYMENTS_URL='https://api.elephant.mifos.io:8243/open-banking/v3.1/pisp/v3.1.2'
WHERE SHORTNAME = 'Elephant';

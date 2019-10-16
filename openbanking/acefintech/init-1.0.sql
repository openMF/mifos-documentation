INSERT INTO BANKS
VALUES ('2ebf6b62-069b-496b-89f1-c4b4b08e04ae', 'Lion', 'Lion', 'Lion Bank DFSP1 Ltd.', '/netbank/images/bank/lion.svg',
        'https://api.lion.mifos.io:8243/token', 'https://api.lion.mifos.io:8243/open-banking/v3.1/aisp/v3.1.2',
        'Jg7O55zbOOlJiSJOaG9Qm5nq7qsa', 'rEpxSqsEJUUGrJt8dcWsvAxIhx8a',
        'http://acefintech.mifos.io/netbank/customer/banks/authorize',
        'acefintech', 'https://api.lion.mifos.io:8243/authorize', 'https://api.lion.mifos.io:8243/open-banking/v3.1/pisp/v3.1.2');
-- INSERT INTO BANKS
--VALUES ('7be1e4c4-c714-409b-b43c-e273b14e3ced', 'Local Lion', 'Lion', 'Lion Bank Ltd.', '/netbank/images/bank/lion.svg',
--        'https://localhost:8243/token', 'https://localhost:8243/ais/v1', 'nYdJa_KHnicVXCYEMNSgKVCiCzwa',
--        'GZhW8YCfC8TC4u2GaRXSXlcRNGwa', 'http://acefintech.org/callback', 'acefintech',
--        'https://172.18.0.5:8243/authorzize');
INSERT INTO USERS
VALUES ('tppuser', '{bcrypt}$2a$10$FgRPdjDFcfxrCzWzVO/mZuWwVEm8CxqRNx4qQAOGVjzh/983lUPJy', TRUE);
INSERT INTO AUTHORITIES
VALUES ('tppuser', 'ROLE_USER');

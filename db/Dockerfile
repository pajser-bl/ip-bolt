FROM postgres:17.2-bookworm

COPY ./init.sql /docker-entrypoint-initdb.d/
COPY ./seed.sql /docker-entrypoint-initdb.d/
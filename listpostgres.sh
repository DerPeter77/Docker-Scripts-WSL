#!/bin/bash

# Listet Docker-Container auf, die "postgres" im Namen oder Image haben
docker ps -a --filter "name=postgres" --filter "ancestor=postgres"
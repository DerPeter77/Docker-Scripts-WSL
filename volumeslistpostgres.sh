#!/bin/bash

# List all Docker volumes with "postgres" in the name
docker volume ls --filter "name=postgres"
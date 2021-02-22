#!/bin/bash

# some environment variables
ENV_ROOT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# restart traefik
echo -n 'Restart traefik... '
cd "$ENV_ROOT_PATH/traefik" && docker-compose down && docker-compose up -d
echo 'Done.' && echo

# restart mail
echo -n 'Restart mail... '
cd "$ENV_ROOT_PATH/mail" && docker-compose down && docker-compose up -d
echo 'Done.' && echo

# restart lamp
echo -n 'Restart lamp... '
cd "$ENV_ROOT_PATH/lamp" && docker-compose down && docker-compose up -d
echo 'Done.' && echo


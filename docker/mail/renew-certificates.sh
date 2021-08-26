#! /bin/bash

# ----------
# Renews the following certificates:
# * mail.ixno.de
#
# Stops and starts traefik proxy if needed
# ----------

# version   v0.0.1 stable
# executed  manually
# task      certificate renewal task

# Read config file
CONFIG_FILE=renew-certificates.conf
if [ ! -f "$CONFIG_FILE" ]; then
    echo "ATTENTION: \"$CONFIG_FILE\" does not exist. Please copy the file \"$CONFIG_FILE.dist\" and adapt it to your needs." && exit 1
fi
source renew-certificates.conf

# Check traefik status
TRAEFIK_OUTPUT=$(docker container ls --filter name=$TRAEFIK_CONTAINER_NAME --format='{{json .}}' | jq .)
TRAEFIK_STATUS=$?
[ "$TRAEFIK_OUTPUT" == "" ] && TRAEFIK_RUNNING=false || TRAEFIK_RUNNING=true

# Shut down Traefik proxy if needed
if $TRAEFIK_RUNNING; then
    echo "==============================================================================="
    echo "Stop Traefik"
    echo "==============================================================================="
    echo
    docker-compose -f $TRAEFIK_DOCKER_COMPOSE_FILE --env-file $TRAEFIK_ENV_FILE down
    echo
fi

# Renew the certificate
echo "==============================================================================="
echo "Try to renew certificates"
echo "==============================================================================="
echo
docker run --rm -ti \
  -v $PWD/log/:/var/log/letsencrypt/ \
  -v $PWD/letsencrypt/:/etc/letsencrypt/ \
  -p 80:80 certbot/certbot certonly --standalone -d $DOMAIN \
  --non-interactive --agree-tos -m $EMAIL
echo

# Start Traefik proxy again
if $TRAEFIK_RUNNING; then
    echo "==============================================================================="
    echo "Start Traefik"
    echo "==============================================================================="
    echo
    docker-compose -f ../traefik/docker-compose.yml --env-file ../traefik/.env up -d
    echo
fi

# List certificate
echo "==============================================================================="
echo "List certificates"
echo "==============================================================================="
echo
sudo ls -l letsencrypt/live/$DOMAIN/
echo


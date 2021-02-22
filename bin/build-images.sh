#!/usr/bin/env bash

# Some environment variables
ENV_BIN_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_ROOT_PATH=$(dirname "$ENV_BIN_PATH")

# Some needed applications
applications=(mmdc)

# ------------
# check if a given application exists
#
# @author  Björn Hempel
# @version 1.0
# ------------
application_exists() {
    `which $1 >/dev/null`
}

# Check applications
echo "Check applications:"
for application in "${applications[@]}"; do
    if application_exists $application; then
        echo "- Application \"$application\" is installed."
    else
        echo "- Application \"$application\" is not installed. Please install it before. → Abort.."
        exit
    fi
done
echo

# Build images
echo -n "Build image overview.png... "
mmdc -i "$ENV_ROOT_PATH/mmd/overview.mmd" -o "$ENV_ROOT_PATH/images/overview.png" --configFile "$ENV_ROOT_PATH/mmd/config.json"
echo "Done."

# Print image info
file "$ENV_ROOT_PATH/images/overview.png" && echo


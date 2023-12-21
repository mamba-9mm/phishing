#!/bin/bash

# I'm not that familiar with docker. Send a PR if something is wrong (^.^)

BASE_DIR=$(realpath
 "$(dirname "$BASH_SOURCE")")
if [[ ! -d "$BASE_DIR/auth" ]]; then
    echo "Creating Auth Directory.."
	mkdir -p "$BASE_DIR/auth"
fi

CONTAINER="phishing"
IMAGE="mamba-9mm/phishing:latest"
IMG_MIRROR="ghcr.io/mamba-9mm/phishing:latest"
MOUNT_LOCATION=${BASE_DIR}/auth
check_container=$(docker ps --all --format "{{.Names}}")

if [[ ! $check_container == $CONTAINER ]]; then
	echo "Creating new container..."
	docker create \
		--interactive --tty \
		--volume ${MOUNT_LOCATION}:/phishing/auth/ \
		--network host \
		--name "${CONTAINER}" \
		"${IMAGE}"
fi

docker start --interactive "${CONTAINER}"

# docker run --rm -ti --network="host" -v ${MOUNT_LOCATION}:/phishing/auth/ --name "$CONTAINER" "$IMAGE"

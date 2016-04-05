#!/bin/bash
set -x
set -e

cd "$(dirname "$0")"

[ $# != 1 ] && exit -1
[ -d "$1" ] || exit -2

OGGM_COMMIT="$(cat oggm_commit.txt)"
TAG="$([ "$TRAVIS_BRANCH" == "master" ] && echo "latest" || echo $TRAVIS_BRANCH)"

BASE="${1}"
REPO="oggm/${BASE}"
DTAG="${REPO}:${OGGM_COMMIT}"

cd "${BASE}"

docker pull "${REPO}" || true
docker build -f Dockerfile -t "${DTAG}" .
docker tag -f "${DTAG}" "${REPO}:${TAG}"
docker tag -f "${DTAG}" "${REPO}:travis-${TRAVIS_BUILD_NUMBER}"

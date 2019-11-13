#!/bin/bash
set -e

if [[ -z "${INPUT_PATH}" || -z "${INPUT_NAME}" ]]; then
    echo "Required input parameter is empty"
    exit -1
fi

if [[ -n "${INPUT_USER}" && -n "${INPUT_PASS}" ]]; then
    echo "Logging into docker registry..."
    printf '%s\n' "${INPUT_PASS}" | docker login -u "${INPUT_USER}" --password-stdin
    echo "Ok"
fi

set -x

cd "${INPUT_PATH}"
DATE_ID="$(date +%Y%m%d)"

EXTRA_ARGS=()
if [[ ${INPUT_FORCE_PULL} != false ]]; then
    EXTRA_ARGS+=( --pull )
fi
if [[ ${INPUT_NO_CACHE} == true ]]; then
    EXTRA_ARGS+=( --no-cache )
fi

docker build "${EXTRA_ARGS[@]}" -t "${INPUT_TMP_TAG}" .

if [[ ${INPUT_NO_PUSH} != false ]]; then
    exit 0
fi

for TAG in ${INPUT_TAGS//,/ }; do
    docker tag "${INPUT_TMP_TAG}" "${INPUT_NAME}:${TAG}"
    docker push "${INPUT_NAME}:${TAG}"
done

if [[ ${INPUT_DATE_TAG} != false ]]; then
    docker tag "${INPUT_TMP_TAG}" "${INPUT_NAME}:${DATE_ID}"
    docker push "${INPUT_NAME}:${DATE_ID}"
fi

if [[ ${INPUT_COMMIT_TAG} != false ]]; then
    docker tag "${INPUT_TMP_TAG}" "${INPUT_NAME}:${GITHUB_SHA}"
    docker push "${INPUT_NAME}:${GITHUB_SHA}"
fi

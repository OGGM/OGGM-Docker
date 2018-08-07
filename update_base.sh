#!/bin/bash

function getSha() {
	branch="master"
	[ -z "$2" ] || branch="$2"
	curl -s -k "https://api.github.com/repos/${1}/commits/${branch}" | python -c 'import json,sys;print(json.load(sys.stdin)["sha"])' || exit -1
}

cd "$(dirname "$0")"

SHA_SALEM="$(getSha fmaussion/salem)"

sed -i -r "s|salem\.git@[A-Za-z0-9]+|salem.git@${SHA_SALEM}|" base/Dockerfile untested_base_py37/Dockerfile || exit -2

cp base/Dockerfile untested_base/Dockerfile
cp base/test.sh untested_base/test.sh


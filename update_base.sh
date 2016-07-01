#!/bin/bash

function getSha() {
	curl -s -k "https://api.github.com/repos/${1}/commits/master" | python -c 'import json,sys;print(json.load(sys.stdin)["sha"])' || exit -1
}

cd "$(dirname "$0")"

SHA_MOTIONLESS="$(getSha fmaussion/motionless)"
SHA_SALEM="$(getSha fmaussion/salem)"
SHA_CLEO="$(getSha fmaussion/cleo)"

if [ -z "$1" ]; then
	SHA_OGGM="$(getSha OGGM/oggm)"
else
	SHA_OGGM="$1"
fi

sed -i -r "s|oggm\.git@[A-Za-z0-9]+|oggm.git@${SHA_OGGM}|" base/Dockerfile || exit -2
sed -i -r "s|salem\.git@[A-Za-z0-9]+|salem.git@${SHA_SALEM}|" base/Dockerfile || exit -2
sed -i -r "s|cleo\.git@[A-Za-z0-9]+|cleo.git@${SHA_CLEO}|" base/Dockerfile || exit -2
sed -i -r "s|motionless\.git@[A-Za-z0-9]+|motionless.git@${SHA_MOTIONLESS}|" base/Dockerfile || exit -2

echo -n "${SHA_OGGM}" > oggm_commit.txt


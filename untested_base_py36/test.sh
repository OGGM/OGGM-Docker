#!/bin/bash
set -e

git clone https://github.com/OGGM/oggm.git /tmp/oggm_git
cd /tmp/oggm_git
"$PIP" install --no-deps --ignore-installed -e .
mkdir fake_home
HOME=/tmp/oggm_git/fake_home pytest --mpl-oggm --mpl-upload oggm
cd -
rm -rf /tmp/oggm_git

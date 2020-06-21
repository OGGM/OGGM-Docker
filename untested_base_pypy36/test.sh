#!/bin/bash
set -e

$PIP install --no-deps --ignore-installed git+https://github.com/OGGM/oggm.git
pytest --mpl-oggm --mpl-upload --pyargs oggm

#!/bin/bash
set -e

python3 -c 'import oggm' 2>/dev/null || /usr/bin/pip3 install git+https://github.com/OGGM/oggm.git
pytest "$(python3 -c 'import oggm, os; print(os.path.dirname(oggm.__file__))')" --mpl

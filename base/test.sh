#!/bin/sh
/usr/bin/pip3 install git+https://github.com/OGGM/oggm.git && /usr/bin/python3 -c 'import nose, os, sys, oggm; os.chdir(os.path.dirname(os.path.abspath(oggm.__file__))); nose.main(argv=["--detailed-errors", "--exe"])'

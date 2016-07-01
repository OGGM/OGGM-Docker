#!/bin/sh
/usr/bin/pip3 install git+https://github.com/OGGM/oggm.git &&
	/usr/bin/pip3 uninstall progressbar2 &&
	/usr/bin/python3 -c 'import nose, os, sys, oggm; os.environ["OGGM_SLOW_TESTS"] = "True"; os.chdir(os.path.dirname(os.path.abspath(oggm.__file__))); nose.main(argv=["--detailed-errors", "--exe"])'

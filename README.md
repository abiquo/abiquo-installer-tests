PRE-REQUISITES
--------------

Install the following ruby gems:

term-ansicolor
iniparse
mixlib-cli


RUNNING THE TESTS
-----------------

./bin/abiquo-installer-tests --host abiquo-host-ip --user root --password secret 

The tests connects to the target host using SSH, uploads the tests and run them in the target host.

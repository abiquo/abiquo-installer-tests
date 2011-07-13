# Abiquo Installer Tests #

Comprehensive test suite to QA and troubleshoot an Abiquo Installation.

The test runner tool automatically detects the Abiquo installation (distributed,mono,cloud node, etc) and runs the required tests.

Only Abiquo 1.7.6 and 1.8.0 installations are supported ATM.

This tool has only been tested in Linux. Other platforms may work though.

# PRE-REQUISITES #

* rubygems

# INSTALLATION #

sudo gem install abiquo-installer-tests

# RUNNING THE TESTS #

abiquo-installer-tests --host abiquo-host-ip --user root --password secret 

The tests connects to the target host using SSH, uploads the tests and run them in the target host.

Sample output:

    Abiquo Installer Test Suite
    ---------------------------
    
    Testing ABIQUO NFS REPOSITORY
    Testing ABIQUO REMOTE SERVICES
    Testing ABIQUO SERVER
    Testing ABIQUO V2V
    
    
    Loaded suite abiquo_postinst_test
    Started
    ........................................
    Finished in 0.396289 seconds.
    
    40 tests, 70 assertions, 0 failures, 0 errors
    
    >>>>>> TEST OK <<<<<<

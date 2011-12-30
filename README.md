# Abiquo Installer Tests #

Comprehensive test suite to QA and troubleshoot an Abiquo Installation.

The test runner tool automatically detects the Abiquo installation (distributed,mono,cloud node, etc) and runs the required tests.

This tool has only been tested in Linux. Other platforms may work though.

# PRE-REQUISITES #

* rubygems

# INSTALLATION #

Install required gems:

sudo gem install net-ssh net-scp net-sftp mixlib-cli term-ansicolor

# RUNNING THE TESTS #

    git clone https://github.com/abiquo/abiquo-installer-tests
    cd abiquo-installer-tests
    ruby ./bin/abiquo-installer-tests --host abiquo-server-ip --user root --password abiquo

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

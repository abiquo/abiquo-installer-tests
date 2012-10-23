class AbiquoPlatformTest < Test::Unit::TestCase
  
    def test_version_string
      assert File.read('/etc/abiquo-release') =~ /\s2\.3/,"Wrong abiquo release version."
    end

    def test_tomcat_core_version
      assert `rpm -q abiquo-core` =~ /abiquo-core-2\.3.*el5/,"Wrong abiquo-core package."
    end

    def test_abiquo_etk_version
      assert `rpm -q rubygem-abiquo-etk` =~ /0\.6\.3/,"Wrong rubygem-abiquo-etk package."
    end

    def test_tomcat_running
      assert !`ps aux|grep java|grep '/opt/abiquo/tomcat'`.strip.chomp.empty?,
              "Abiquo Tomcat is not Running"
    end
    
    def test_tomcat_enabled
      assert ::TestUtils.service_on?('abiquo-tomcat'),
        "abiquo-tomcat service is not enabled"
    end

    def test_abiquo_dir
      assert File.directory?('/opt/abiquo/tomcat'),
        "/opt/abiquo/tomcat directory does not exist"
    end
    
    def test_firewall_service_enabled
      assert !::TestUtils.service_on?('iptables'),
        "WARNING: iptables service is enabled. This might be ok but double check the firewall rules if you are having problems connecting to the hypervisor."
    end

end

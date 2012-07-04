class AbiquoPlatformTest < Test::Unit::TestCase
  
    def test_version_string
      assert File.read('/etc/abiquo-release') =~ /\s2\.2/
    end

    def test_tomcat_core_version
      assert `rpm -q abiquo-core` =~ /abiquo-core-2\.2.*el5/
    end

    def test_abiquo_etk_version
      assert `rpm -q rubygem-abiquo-etk` =~ /0\.6\.2/
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

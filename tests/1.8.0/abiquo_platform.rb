class AbiquoPlatformTest < Test::Unit::TestCase
  
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
        "iptables service is enabled. This might be ok but double check if you are having network issues"
    end

end

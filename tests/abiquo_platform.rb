module AbiquoPlatformTestMethods
  
    def test_tomcat_running
      assert !`ps aux|grep java|grep '/opt/abiquo/tomcat'`.strip.chomp.empty?
    end
    
    def test_tomcat_enabled
      assert ::TestUtils.service_on?('abiquo-tomcat')
    end

    def test_firewall
      assert !::TestUtils.service_on?('iptables')
    end
    
    def test_abiquo_dir
      assert File.directory? '/opt/abiquo/tomcat'
    end
    
    def test_firewall_service_enabled
      assert !::TestUtils.service_on?('iptables')
    end

end

class AbiquoPlatformTest < Test::Unit::TestCase
  include AbiquoPlatformTestMethods
end

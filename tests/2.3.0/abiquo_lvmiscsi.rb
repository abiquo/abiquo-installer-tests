class AbiquoLVMISCSITest < Test::Unit::TestCase
  
    def test_tomcat_running
      assert !`ps aux|grep java|grep '/opt/abiquo/lvmiscsi/tomcat'`.strip.chomp.empty?,"lvmiscsi webapp does not exist."
    end
    
    def test_tomcat_enabled
      assert ::TestUtils.service_on?('abiquo-lvmiscsi'),"abiquo-lvmiscsi service not enabled."
    end

    def test_firewall_service_enabled
      unless ::TestUtils.installer_profiles.include? 'cloud-in-a-box'
        assert !::TestUtils.service_on?('iptables'),"WARNING: iptables enabled."
      end
    end

end

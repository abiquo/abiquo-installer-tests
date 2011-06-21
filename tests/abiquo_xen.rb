class AbiquoXenTest < Test::Unit::TestCase
  
    def test_aim_running
      assert !`ps aux|grep abiquo-aim`.strip.chomp.empty?
    end

    def test_aim_service_enabled
      assert ::TestUtils.service_on?('abiquo-aim')
    end
    
    def test_libvirtd_service_enabled
      assert ::TestUtils.service_on?('libvirtd')
    end

    def test_firewall_service_enabled
      assert !::TestUtils.service_on?('iptables')
    end

    def test_abiquo_aim_properties_file
      assert File.exist? '/etc/abiquo-aim.ini'
    end
    
    def test_nfs_mounted
      assert !`mount|grep vm_repository`.strip.chomp.empty?
    end
    
end

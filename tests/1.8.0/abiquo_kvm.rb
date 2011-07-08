class AbiquoKVMTest < Test::Unit::TestCase
  
    def test_aim_running
      assert !`ps aux|grep abiquo-aim`.strip.chomp.empty?
    end

    def test_aim_service_enabled
      assert ::TestUtils.service_on?('abiquo-aim')
    end
    
    def test_libvirtd_service_enabled
      assert ::TestUtils.service_on?('libvirtd')
    end

    def test_abiquo_aim_properties_file
      assert File.exist? '/etc/abiquo-aim.ini'
    end
    
    def test_nfs_mounted
      if !::TestUtils.installer_profiles.include?('cloud-in-a-box')
        assert !`mount|grep vm_repository`.strip.chomp.empty?
      end
    end
    
end

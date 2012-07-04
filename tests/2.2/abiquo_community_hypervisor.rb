class AbiquoCommunityHypervisor < Test::Unit::TestCase
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
      assert !::TestUtils.service_on?('iptables'),
        "WARNING: iptables service is enabled. This might be ok but double check the firewall rules if you are having problems connecting to the hypervisor."
    end
    
    def test_abiquo_aim_properties_file
      assert File.exist? '/etc/abiquo-aim.ini'
    end
    
    def test_nfs_mounted
      # It's ok if the NFS isn't mounted in a CIAB install
      if not TestUtils.installer_profiles.include? 'cloud-in-a-box'
        assert !`mount|grep vm_repository`.strip.chomp.empty?
      end
    end
    
  
    def test_valid_libvirt_conf
      buff = File.read '/etc/libvirt/libvirtd.conf'

      if buff =~ /^auth_tls.*none/ and \
           buff =~ /^tcp_port.*16509/ and \
              buff =~ /^auth_tcp.*none/
        assert true
      else
        assert false, "Invalid /etc/libvirt/libvirtd.conf"
      end
    end
    
    def test_valid_libvirt_sysconfig
      buff = File.read '/etc/sysconfig/libvirtd'
      if buff =~ /^LIBVIRTD_ARGS.*--listen/ 
        assert true
      else
        assert false, "Invalid /etc/sysconfig/libvirtd"
      end
    end
    
end

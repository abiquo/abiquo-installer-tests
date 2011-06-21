class AbiquoMonolithicTest < Test::Unit::TestCase
  
    def test_abiquo_properties_present
      assert File.exist? '/opt/abiquo/config/abiquo.properties'
    end

    def test_mysql_schema_present
      assert(`mysql -e 'show databases' 2>&1` =~ /kinton/m)
    end

    def test_tomcat_running
      assert !`ps aux|grep java|grep '/opt/abiquo/tomcat'`.strip.chomp.empty?
    end

    def test_mysql_running
      assert !`service mysqld status|grep running`.strip.chomp.empty?
    end

    def test_redis_running
      assert !`ps aux|grep java|grep redis`.strip.chomp.empty?
    end
    
    def test_rabbit_running
      assert !`ps aux|grep java|grep rabbitmq`.strip.chomp.empty?
    end

    def test_nfs_mounted
      if not ::TestUtils.installer_profiles.include?('abiquo-nfs-repository')
        assert !`mount|grep vm_repository`.strip.chomp.empty?
      end
    end

    def test_cifs_enabled
      if ::TestUtils.installer_profiles.include?('abiquo-nfs-repository')
        assert ::TestUtils.service_on?('smb')
      end
    end

    def test_cifs_running
      if ::TestUtils.installer_profiles.include?('abiquo-nfs-repository')
        assert !`service smb status|grep running`.strip.chomp.empty?
      end
    end

    def test_firewall
      assert !::TestUtils.service_on?('iptables')
    end

end
require 'abiquo_platform'

class AbiquoRemoteServicesTest < Test::Unit::TestCase
  
    def test_required_packages
      %w{abiquo-remote-services abiquo-vsm abiquo-ssm abiquo-virtualfactory abiquo-nodecollector abiquo-core ntp nfs-utils jdk}.each do |p|
        assert !`rpm -q #{p}`.strip.chomp.empty?, "#{p} package not installed."
      end
    end

    def test_abiquo_properties_present
      assert File.exist?('/opt/abiquo/config/abiquo.properties'),
        'abiquo.properties file not found'
    end

    def test_redis_running
      assert !`ps aux|grep java|grep redis`.strip.chomp.empty?,
        'redis is not running'
        
    end
    
    def test_nfs_mounted
      if not ::TestUtils.installer_profiles.include?('abiquo-nfs-repository') and \
        !::TestUtils.installer_profiles.include?('cloud-in-a-box')
        assert !`mount|grep vm_repository`.strip.chomp.empty?
      end
    end

    def test_webapps_deployed?
      %w{virtualfactory vsm ssm am nodecollector}.each do |w|
        assert TestUtils.webapp_deployed?(w), "#{w} Tomcat webapp not found in #{TestUtils.abiquo_base_dir}/tomcat/webapps"
      end
    end

    def test_dhcpd_enabled
      assert ::TestUtils.service_on?('dhcpd')
    end

    def test_am
      assert ::TestUtils.web_service_ok?('am/check'), "AM webapp status is not OK. Check for tomcat errors."
    end

    def test_vsm
      assert ::TestUtils.web_service_ok?('vsm/check'), "VSM webapp status is not OK. Check for tomcat errors."
    end

    def test_nodecollector
      assert ::TestUtils.web_service_ok?('nodecollector/check'), "NodeCollector webapp status is not OK. Check for tomcat errors."
    end
    
    def test_ssm
      assert ::TestUtils.web_service_ok?('ssm/check'), "SSM webapp status is not OK. Check for tomcat errors."
    end

    def test_virtualfactory
      assert ::TestUtils.web_service_ok?('virtualfactory/check'), "Virtualfactory webapp status is not OK. Check for tomcat errors."
    end
    
    def test_abiquo_repository_file
      assert File.exist?('/opt/vm_repository/.abiquo_repository'), "File /opt/vm_repository/.abiquo_repository not found"
    end

    def test_properties
      require 'iniparse'
      config = IniParse.parse(File.read('/opt/abiquo/config/abiquo.properties'))
      assert !config['remote-services'].nil?,
        "[remote-services] section in /opt/abiquo/config/abiquo.properties is missing"

      assert !config['remote-services']['abiquo.rabbitmq.username'].nil?,
        "abiquo.rabbitmq.username property is missing in abiquo.properties"

      assert !config['remote-services']['abiquo.rabbitmq.password'].nil?,
        "abiquo.rabbitmq.password property is missing in abiquo.properties"

      assert !config['remote-services']['abiquo.rabbitmq.host'].nil?,
        "abiquo.rabbitmq.host property is missing in abiquo.properties"

      assert !config['remote-services']['abiquo.rabbitmq.port'].nil?,
        "abiquo.rabbitmq.port property is missing in abiquo.properties"

      assert !config['remote-services']['abiquo.appliancemanager.localRepositoryPath'].nil?,
        "abiquo.appliancemanager.localRepositoryPath property is missing in abiquo.properties"

      assert !config['remote-services']['abiquo.appliancemanager.repositoryLocation'].nil?,
        "abiquo.appliancemanager.repositoryLocation property is missing in abiquo.properties"

      assert !config['remote-services']['abiquo.redis.port'].nil?,
        "abiquo.redis.port is missing in abiquo.properties"

      assert !config['remote-services']['abiquo.redis.host'].nil?,
        "abiquo.redis.host is missing in abiquo.properties"

      assert !config['remote-services']['abiquo.datacenter.id'].nil?,
        "abiquo.datacenter.id property is missing in abiquo.properties"

    end

end

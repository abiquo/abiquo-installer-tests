require 'abiquo_platform'

class AbiquoRemoteServicesTest < Test::Unit::TestCase

    def test_abiquo_properties_present
      assert File.exist? '/opt/abiquo/config/abiquo.properties'
    end

    def test_redis_running
      assert !`ps aux|grep java|grep redis`.strip.chomp.empty?
    end
    
    def test_nfs_mounted
      if not ::TestUtils.installer_profiles.include?('abiquo-nfs-repository') and \
        !::TestUtils.installer_profiles.include?('cloud-in-a-box')
        assert !`mount|grep vm_repository`.strip.chomp.empty?
      end
    end

    def test_dhcpd_enabled
      assert ::TestUtils.service_on?('dhcpd')
    end

    def test_am
      assert ::TestUtils.web_service_ok?('/am/check')
    end

    def test_vsm
      assert ::TestUtils.web_service_ok?('/vsm/check')
    end

    def test_nodecollector
      assert ::TestUtils.web_service_ok?('/nodecollector/check')
    end
    
    def test_ssm
      assert ::TestUtils.web_service_ok?('/ssm/check')
    end

    def test_virtualfactory
      assert ::TestUtils.web_service_ok?('/virtualfactory/check')
    end
    
    def test_abiquo_repository_file
      assert File.exist? '/opt/vm_repository/.abiquo_repository'
    end

    def test_properties
      require 'iniparse'
      config = IniParse.parse(File.read('/opt/abiquo/config/abiquo.properties'))
      assert !config['remote-services'].nil?
      assert !config['remote-services']['abiquo.virtualfactory.hyperv.repositoryLocation'].nil?
      assert !config['remote-services']['abiquo.rabbitmq.username'].nil?
      assert !config['remote-services']['abiquo.rabbitmq.password'].nil?
      assert !config['remote-services']['abiquo.rabbitmq.host'].nil?
      assert !config['remote-services']['abiquo.rabbitmq.port'].nil?
      assert !config['remote-services']['abiquo.appliancemanager.localRepositoryPath'].nil?
      assert !config['remote-services']['abiquo.appliancemanager.repositoryLocation'].nil?
      assert !config['remote-services']['abiquo.virtualfactory.xenserver.repositoryLocation'].nil?
      assert !config['remote-services']['abiquo.virtualfactory.vmware.repositoryLocation'].nil?
      assert !config['remote-services']['abiquo.virtualfactory.storagelink.user'].nil?
      assert !config['remote-services']['abiquo.virtualfactory.storagelink.password'].nil?
      assert !config['remote-services']['abiquo.virtualfactory.storagelink.address'].nil?
      assert !config['remote-services']['abiquo.redis.port'].nil?
      assert !config['remote-services']['abiquo.redis.host'].nil?
      assert !config['remote-services']['abiquo.storagemanager.netapp.user'].nil?
      assert !config['remote-services']['abiquo.storagemanager.netapp.password'].nil?
      assert !config['remote-services']['abiquo.dvs.enabled'].nil?
      assert !config['remote-services']['abiquo.dvs.vcenter.user'].nil?
      assert !config['remote-services']['abiquo.dvs.vcenter.password'].nil?
    end

end

require 'abiquo_platform'

class AbiquoV2VTest < Test::Unit::TestCase
    
    def test_required_packages
      %w{abiquo-v2v abiquo-core ntp nfs-utils jdk}.each do |p| 
        assert !`rpm -q #{p}`.strip.chomp.empty?, "#{p} package not installed."
      end
    end

    def test_mechadora_available
      assert File.exist?('/usr/bin/mechadora'), "Mechadora script not found in /usr/bin/mechadora"
    end
    
    def test_v2v_diskmanager_available
      assert File.exist?('/usr/bin/v2v-diskmanager'), "V2V Disk Manager script not found in /usr/bin/v2v-diskmanager"
    end
  
    def test_tomcat_running
      assert !`ps aux|grep java|grep '/opt/abiquo/tomcat'`.strip.chomp.empty?
    end

    def test_nfs_mounted
      if (not ::TestUtils.installer_profiles.include?('abiquo-nfs-repository')) and \
          (! ::TestUtils.installer_profiles.include?('cloud-in-a-box'))
        assert !`mount|grep vm_repository`.strip.chomp.empty?
      end
    end
    def test_webapps_deployed?
      %w{bpm-async}.each do |w|
        assert TestUtils.webapp_deployed?(w), "#{w} Tomcat webapp not found in #{TestUtils.abiquo_base_dir}/tomcat/webapps"
      end
    end
    
    def test_abiquo_repository_file
      assert File.exist? '/opt/vm_repository/.abiquo_repository'
    end
    
    def test_tomcat_enabled
      assert ::TestUtils.service_on?('abiquo-tomcat')
    end

    def test_v2v_context_present
      assert File.directory? '/opt/abiquo/tomcat/webapps/bpm-async'
    end

    def test_v2v_scripts
      assert File.exist?('/usr/bin/mechadora')
      assert File.exist?('/usr/bin/v2v-diskmanager')
    end

    def test_abiquo_dir
      assert File.directory? '/opt/abiquo'
    end
    
    def test_abiquo_properties_present
      assert File.exist?('/opt/abiquo/config/abiquo.properties'),
        'abiquo.properties file not found'
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
      
      assert !config['remote-services']['abiquo.datacenter.id'].nil?,
        "abiquo.datacenter.id property is missing in abiquo.properties"

    end

end

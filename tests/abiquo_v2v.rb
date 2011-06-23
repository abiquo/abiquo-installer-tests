require 'abiquo_platform'

class AbiquoV2VTest < Test::Unit::TestCase
  
    def test_tomcat_running
      assert !`ps aux|grep java|grep '/opt/abiquo/tomcat'`.strip.chomp.empty?
    end

    def test_nfs_mounted
      if (not ::TestUtils.installer_profiles.include?('abiquo-nfs-repository')) and \
          (! ::TestUtils.installer_profiles.include?('cloud-in-a-box'))
        assert !`mount|grep vm_repository`.strip.chomp.empty?
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

end

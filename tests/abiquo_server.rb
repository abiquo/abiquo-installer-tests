class AbiquoServerTest < Test::Unit::TestCase
  
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
    
    def test_tomcat_enabled
      assert ::TestUtils.service_on?('abiquo-tomcat')
    end

    def test_rabbit_running
      assert !`ps aux|grep java|grep rabbitmq`.strip.chomp.empty?
    end

    def test_firewall
      assert !::TestUtils.service_on?('iptables')
    end
    
    def test_server_ws
      assert ::TestUtils.web_service_ok?('/server/messagebroker/amf')
    end
    
    def test_abiquo_dir
      assert File.directory? '/opt/abiquo'
    end

end

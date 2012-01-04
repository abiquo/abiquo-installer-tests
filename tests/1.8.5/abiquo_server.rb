require 'abiquo_platform'

class AbiquoServerTest < Test::Unit::TestCase
  
    def test_abiquo_properties_present
      assert File.exist? '/opt/abiquo/config/abiquo.properties'
    end

    def test_mysql_schema_present
      assert(`mysql -e 'show databases' 2>&1` =~ /kinton/m)
    end

    def test_mysql_running
      assert !`service mysqld status|grep running`.strip.chomp.empty?
    end
    
    def test_rabbit_running
      assert !`ps aux|grep java|grep rabbitmq`.strip.chomp.empty?
    end

    def test_server_ws
      assert ::TestUtils.web_service_ok?('/server/messagebroker/amf')
    end
    
    def test_properties
      require 'iniparse'
      config = IniParse.parse(File.read('/opt/abiquo/config/abiquo.properties'))
      assert !config['server'].nil?,
        "[server] section is missing in missing in abiquo.properties"

      assert !config['server']['abiquo.server.sessionTimeout'].nil?,
        "abiquo.server.sessionTimeout is missing in abiquo.properties"

      assert !config['server']['abiquo.server.mail.server'].nil?,
        "abiquo.server.mail.server is missing in abiquo.properties"

      assert !config['server']['abiquo.server.mail.user'].nil?,
        "abiquo.server.mail.user is missing in abiquo.properties"

      assert !config['server']['abiquo.server.mail.password'].nil?,
        "abiquo.server.mail.password is missing in abiquo.properties"

      assert !config['server']['abiquo.rabbitmq.username'].nil?,
        "abiquo.rabbitmq.username is missing in abiquo.properties"

      assert !config['server']['abiquo.rabbitmq.password'].nil?,
        "abiquo.rabbitmq.host is missing in abiquo.properties"

      assert !config['server']['abiquo.rabbitmq.host'].nil?,
        "abiquo.rabbitmq.host is missing in abiquo.properties"

      assert !config['server']['abiquo.rabbitmq.port'].nil?,
        "abiquo.rabbitmq.port is missing in abiquo.properties"

      assert !config['server']['abiquo.database.user'].nil?,
        "abiquo.database.user is missing in abiquo.properties"

      assert !config['server']['abiquo.auth.module'].nil?,
        "abiquo.auth.module is missing in abiquo.properties"
    end

end


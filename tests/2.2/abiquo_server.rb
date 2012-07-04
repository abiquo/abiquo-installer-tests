require 'abiquo_platform'

class AbiquoServerTest < Test::Unit::TestCase
  
  def test_required_packages
    %w{abiquo-server abiquo-api abiquo-client-premium abiquo-core ntp nfs-utils jdk redis}.each do |p|
      assert !`rpm -q #{p}`.strip.chomp.empty?, "#{p} package not installed."
    end
  end

  def test_abiquo_properties_present
    assert File.exist? '/opt/abiquo/config/abiquo.properties'
  end

  def test_mysql_schema_present
    assert(`mysql -e 'show databases' 2>&1` =~ /kinton/m)
  end

  def test_mysql_running
    assert !`service mysqld status|grep running`.strip.chomp.empty?
  end
  
  def test_redis_running
    assert !`ps aux|grep redis-server`.strip.chomp.empty?
  end
  
  def test_rabbit_running
    assert !`ps aux|grep java|grep rabbitmq`.strip.chomp.empty?
  end
    
  def test_motd_service
    assert ::TestUtils.service_on?('motd'), "MOTD service not enabled"
    assert File.exist?('/etc/init.d/motd'), "MOTD service (/etc/init.d/motd) not installed"
  end

  def test_api_ws
    assert TestUtils.web_service_auth_required?('/api/console'), "API webapp status is not OK. Check for tomcat errors."
  end
  
  def test_webapps_deployed?
    %w{api ROOT client-premium server}.each do |w|
      assert TestUtils.webapp_deployed?(w), "#{w} Tomcat webapp not found in #{TestUtils.abiquo_base_dir}/tomcat/webapps"
    end
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
    
    assert !config['server']['abiquo.server.api.location'].nil?,
      "abiquo.server.api.location is missing in abiquo.properties"

    if not TestUtils.webapp_deployed?('virtualfactory')
      assert !config['server']['abiquo.redis.host'].nil?,
        "abiquo.redis.host is missing in abiquo.properties"
      assert !config['server']['abiquo.redis.port'].nil?,
        "abiquo.redis.port is missing in abiquo.properties"
    end

  end

end


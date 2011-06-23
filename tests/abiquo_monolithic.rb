require 'abiquo_platform'
require 'abiquo_remote_services'
require 'abiquo_server'
require 'abiquo_v2v'

class AbiquoMonolithicTest < Test::Unit::TestCase
  def test_webapps
    %w(am api bpm-async client-premium legal nodecollector ROOT server ssm virtualfactory vsm).each do |w|
      assert(File.directory? "/opt/abiquo/tomcat/webapps/#{w}")
    end
  end
end

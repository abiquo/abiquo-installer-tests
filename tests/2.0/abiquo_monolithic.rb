require 'abiquo_platform'
require 'abiquo_remote_services'
require 'abiquo_server'
require 'abiquo_v2v'

class AbiquoMonolithicTest < Test::Unit::TestCase
    def test_required_packages
      %w{abiquo-pocsetup abiquo-core ntp nfs-utils}.each do |p|
        assert !`rpm -q #{p}`.strip.chomp.empty?, "#{p} package not installed"
      end
    end
end

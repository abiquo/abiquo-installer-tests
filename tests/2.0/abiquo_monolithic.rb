require 'abiquo_platform'
require 'abiquo_remote_services'
require 'abiquo_server'
require 'abiquo_v2v'

class AbiquoMonolithicTest < Test::Unit::TestCase
    def test_required_packages
      %w{abiquo-pocsetup abiquo-core ntp nfs-utils}.each do |p|
        assert !`rpm -q #{p}`.strip.chomp.empty?, "#{p} package not installed."
      end
    end

    def test_repository_location_property
      if TestUtils.installer_profiles.include?('abiquo-nfs-repository')
        prop = TestUtils.find_abiquo_property 'abiquo.appliancemanager.repositoryLocation'
        assert !prop.nil?
        pval = prop.split("=")[1].strip.chomp
        assert (pval =~ /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?):\//).eql?(0), 
               "Invalid abiquo.appliancemanager.repositoryLocation property value: #{pval}"
      end
    end

end

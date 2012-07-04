require 'abiquo_platform'
require 'abiquo_remote_services'
require 'abiquo_server'
require 'abiquo_v2v'
require 'abiquo_monolithic'
require 'abiquo_kvm'
require 'abiquo_lvmiscsi'

class AbiquoCIABTest < Test::Unit::TestCase
  def test_lvm_tomcat_dir
    assert File.directory? '/opt/abiquo/lvmiscsi/tomcat/'
  end

  #
  # overriding abiquo_platform test
  # FW can be safely enabled in CIAB installs
  #
  def test_firewall_service_enabled
    assert true
  end

  def test_fullvirt_disabled
    prop = TestUtils.find_abiquo_property 'abiquo.virtualfactory.kvm.fullVirt'
    assert !prop.nil?, "Property abiquo.virtualfactory.kvm.fullVirt not found"
    pval = prop.split("=")[1].strip.chomp
    assert (pval == 'false'),
           "Invalid abiquo.virtualfactory.kvm.fullVirt property value. Value should be false."
  end

end

require 'rubygems'
require 'test/unit'
require 'yaml'
require 'term/ansicolor'
require 'iniparse'
require 'net/http'
require 'uri'

class String
  include Term::ANSIColor
end

class TestUtils 

  # 
  # Should return an array of installer profiles
  # otherwise the installation is broken
  #
  def self.installer_profiles
    begin
      buf = File.read '/etc/abiquo-installer' 
      buf =~ /Installed Profiles:(.*)$/
      return eval $1.strip.chomp
    rescue Exception
      return nil
    end
  end

  def self.find_abiquo_property(prop_name, prop_file = "/opt/abiquo/config/abiquo.properties")
    File.read(prop_file).lines.find { |l| l.strip.chomp =~ /^#{prop_name}/ }
  end

  def self.service_on?(service)
    ENV['LANG'] = 'POSIX'
    `/sbin/chkconfig --list #{service}` =~ /3:on/
  end

  def self.web_service_auth_required?(path, host = 'localhost')
    res = Net::HTTP.get_response URI.parse("http://#{host}/#{path}")
    return res.is_a? Net::HTTPUnauthorized
  end

  def self.web_service_ok?(path, host = 'localhost')
    res = Net::HTTP.get_response URI.parse("http://#{host}/#{path}")
    return res.is_a? Net::HTTPOK
  end

  def self.abiquo_version
    return nil if not File.exist?('/etc/abiquo-release')
    buf = File.read '/etc/abiquo-release'
    buf =~ /Version:\s*(([0-9]|\.)+).*$/
    puts buf
    $1
  end

  def self.abiquo_base_dir
    "/opt/abiquo"
  end

  def self.webapp_deployed?(webapp)
    File.directory? "#{abiquo_base_dir}/tomcat/webapps/#{webapp}"
  end

end

class BaseTest < Test::Unit::TestCase

  def test_etk_present
    assert File.exist? '/usr/bin/abiquo-check-install'
    assert File.exist? '/usr/bin/abicli'
  end

  def test_installer_profiles_present
    assert TestUtils.installer_profiles.is_a? Array
    assert !TestUtils.installer_profiles.empty?
  end

  def test_abiquo_installer_file
    assert File.exist? '/etc/abiquo-installer'
  end
  def test_abiquo_release_file
    assert File.exist? '/etc/abiquo-release'
  end

end

if not File.exist? '/etc/abiquo-installer'
  $stderr.puts ""
  $stderr.puts "/etc/abiquo-installer file not found in the Abiquo host."
  $stderr.puts "Can't continue testing :("
  $stderr.puts ""
  exit 1
else

  $stdout.sync = true
  version = TestUtils.abiquo_version
  $: << version
  if version.nil?
    puts "Can't find Abiquo Version in /etc/abiquo-release"
    exit 1
  end

  if not File.directory?(version)
    puts "Can't find tests for Abiquo Version #{version}"
    exit 1
  end

  puts "\n\n"
  puts "Abiquo Version #{version.bold} detected"
  puts 
  puts "Abiquo Installer Test Suite"
  puts "---------------------------"
  puts ""
  if TestUtils.installer_profiles.include? 'abiquo-monolithic'
    puts "Testing " + "ABIQUO MONOLITHIC".yellow.bold
    load version + '/abiquo_monolithic.rb'
  end
  if TestUtils.installer_profiles.include? 'abiquo-nfs-repository'
    puts "Testing " + "ABIQUO NFS REPOSITORY".yellow.bold
    load version + '/abiquo_nfs_repository.rb'
  end
  if TestUtils.installer_profiles.include? 'abiquo-remote-services'
    puts "Testing " + "ABIQUO REMOTE SERVICES".yellow.bold
    load version + '/abiquo_remote_services.rb'
  end
  if TestUtils.installer_profiles.include? 'abiquo-server'
    puts "Testing " + "ABIQUO SERVER".yellow.bold
    load version + '/abiquo_server.rb'
  end
  if TestUtils.installer_profiles.include? 'abiquo-v2v'
    puts "Testing " + "ABIQUO V2V".yellow.bold
    load version + '/abiquo_v2v.rb'
  end
  if TestUtils.installer_profiles.include? 'abiquo-kvm'
    puts "Testing " + "ABIQUO KVM".yellow.bold
    load version + '/abiquo_kvm.rb'
  end
  if TestUtils.installer_profiles.include? 'abiquo-xen'
    puts "Testing " + "ABIQUO XEN".yellow.bold
    load version + '/abiquo_xen.rb'
  end
  if TestUtils.installer_profiles.include? 'cloud-in-a-box'
    puts "Testing " + "ABIQUO CIAB".yellow.bold
    load version + '/abiquo_ciab.rb'
  end

  puts "\n\n"

end

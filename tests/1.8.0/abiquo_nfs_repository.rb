class NFSRepositoryTest < Test::Unit::TestCase
  
  def test_abiquo_repository_file
    assert File.exist? '/opt/vm_repository/.abiquo_repository'
  end

  def test_exports_file
    assert File.exist? '/etc/exports'
  end

  def test_exports_file_contents
    count = 0
    File.read('/etc/exports').each_line do |l|
      count += 1 if l =~ /\/opt\/vm_repository/
    end
    assert(count == 1)
  end

  def test_nfs_service_on
    assert(::TestUtils.service_on? 'nfs')
  end

end

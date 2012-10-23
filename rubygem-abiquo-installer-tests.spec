%define rbname abiquo-installer-tests
%define version 20121023.3 
%define release 1

Summary: Abiquo Installer Unit Tests
Name: rubygem-%{rbname}

Version: %{version}
Release: %{release}%{?dist}
Group: Development/Ruby
License: Distributable
URL: http://github.com/abiquo/abiquo-installer-tests
Source0: http://rubygems.org/downloads/%{rbname}-%{version}.gem
BuildRoot: %{_tmppath}/%{name}-%{version}-root
Requires: rubygems
Requires: rubygem-term-ansicolor >= 1.0
#Requires: rubygem-net-ssh >= 2.0
#Requires: rubygem-net-scp >= 1.0
#Requires: rubygem-net-sftp >= 2.0
Requires: rubygem-iniparse >= 1.0
Requires: rubygem-mixlib-cli >= 1.2
BuildRequires: rubygems
BuildArch: noarch
Provides: rubygem(Abiquo-installer-tests) = %{version}

%define gemdir %(ruby -rubygems -e 'puts Gem::dir' 2>/dev/null)
%define gembuilddir %{buildroot}%{gemdir}

%description
Tests and troubleshoot Abiquo installations


%prep
%setup -T -c

%build

%install
%{__rm} -rf %{buildroot}
mkdir -p %{gembuilddir}
gem install --no-ri --no-rdoc --local --install-dir %{gembuilddir} --force %{SOURCE0}
mkdir -p %{buildroot}/%{_bindir}
mv %{gembuilddir}/bin/* %{buildroot}/%{_bindir}
rmdir %{gembuilddir}/bin
rm %{buildroot}/%{gemdir}/cache/%{rbname}-%{version}.gem

%clean
%{__rm} -rf %{buildroot}

%files
%defattr(-, root, root)
%{_bindir}/abiquo-installer-tests
%doc %{gemdir}/gems/abiquo-installer-tests-%{version}/README.md
%{gemdir}/gems/abiquo-installer-tests-%{version}/
%{gemdir}/specifications/abiquo-installer-tests-%{version}.gemspec

%changelog
* Tue Oct 23 2012 Abel Boldú <abel.boldu@abiquo.com> - 20121023.3-1
- Added ssh vendor gems. 2.3 tests

* Wed Jan 04 2012 Sergio Rubio <srubio@abiquo.com> - 20120104.1-1
- upstream update

* Wed Jan 04 2012 Sergio Rubio <srubio@abiquo.com> - 20120104-1
- initial release


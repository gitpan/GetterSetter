Summary: Perl module which will automagically create getter/setter methods
Name: perl-GetterSetter
Version: 0.01
Release: 1
Copyright: Perl
Group: Development/Libraries

%define realname GetterSetter
Packager: Eric Anderson <eric.anderson@cordata.net>
BuildRoot: %{_tmppath}/%{name}-%{version}-root
Source: %{realname}-%{version}.tar.gz
Requires: perl
BuildArchitectures: noarch

%description
Will allow getter and setter methods to be easily defined by simply
calling a function in your BEGIN code. It will not overwrite real
functions already in the text of the code to prevent accidental
overwrites of more complex getter and setter methods.

# Provide perl-specific find-{provides,requires}.
%define __find_provides /usr/lib/rpm/find-provides.perl
%define __find_requires /usr/lib/rpm/find-requires.perl

%prep
%setup -n %{realname}-%{version}

%build
CFLAGS="$RPM_OPT_FLAGS" %{__perl} Makefile.PL
make

%clean
rm -rf $RPM_BUILD_ROOT

%install
rm -rf $RPM_BUILD_ROOT
eval `%{__perl} '-V:installarchlib'`
eval `${__perl} '-V:installsitearch'`
mkdir -p $RPM_BUILD_ROOT/$installarchlib
make PREFIX=$RPM_BUILD_ROOT/usr install
rm -f $RPM_BUILD_ROOT/$installarchlib/perllocal.pod
rm -f $RPM_BUILD_ROOT/$installsitearch/auto/Attribute/Handlers/.packlist

%files
%defattr(-,root,root)
%doc Changes README
/usr/lib/perl5/*
%doc %{_mandir}/*/*

%changelog
* Wed Oct 30 2002 Eric Anderson <eric.anderson@cordata.net>
- Inital build of GetterSetter module

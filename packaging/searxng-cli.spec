Name:           searxng-cli
Version:        0.1.0
Release:        1%{?dist}
Summary:        Shell wrapper for SearXNG with carapace completions
License:        MIT
URL:            https://github.com/3dyuval/searxng-cli
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch
Requires:       curl jq xdg-utils
BuildRequires:  make

%description
Search the web from your terminal using a SearXNG instance.
Supports multiple output formats, engine/category filtering,
and shell completions via carapace.

%prep
%autosetup

%install
%make_install PREFIX=/usr VERSION=%{version}

%files
%license LICENSE
%{_bindir}/searxng
%{_datadir}/searxng-cli/searxng.sh
%{_datadir}/searxng-cli/searxng.yaml

%changelog
* Thu Feb 20 2026 Yuval.D <yuvddd@pm.me> - 0.1.0-1
- Initial package

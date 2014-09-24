template "/etc/yum.repos.d/Epel.repo" do
    source "Epel.repo.erb"
end

template "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL" do
    source "RPM-GPG-KEY-EPEL.erb"
end


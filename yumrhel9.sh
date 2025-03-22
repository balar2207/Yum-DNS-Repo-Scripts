#/bin/bash
mkdir -p /var/www/html/repos/rhel9
sed -i -e '$aUUID=1e203453-1c24-4e0b-a9cb-9414982fa7d9 /var/www/html/repos ext4 defaults        0 0' /etc/fstab
mount -a
mkdir -p /etc/yum.repos.d/disabled/
mv /etc/yum.repos.d/*.repo* /etc/yum.repos.d/disabled/
touch /etc/yum.repos.d/rhel9-local.repo
cat > /etc/yum.repos.d/rhel9-local.repo <<EOF
[Local-BaseOS]
name=Red Hat Enterprise Linux 9 - BaseOS
metadata_expire=-1
gpgcheck=0
enabled=1
baseurl=file:///var/www/html/repos/rhel9/BaseOS/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[Local-AppStream]
name=Red Hat Enterprise Linux 9 - AppStream
metadata_expire=-1
gpgcheck=0
enabled=1
baseurl=file:///var/www/html/repos/rhel9/AppStream/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF
dnf remove subscription-manager -y
yum clean all
yum repolist all

echo "The yum/dnf local repoisoty is setup and the Data volume is mounted persistently"

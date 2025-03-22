#/bin/bash
mkdir -p /var/www/html/repos/centos9
sed -i -e '$aUUID=8a2b9475-b031-4dee-9fea-0f26a8fb9567 /var/www/html/repos ext4 defaults        0 0' /etc/fstab
mount -a
mkdir -p /etc/yum.repos.d/disabled/
mv /etc/yum.repos.d/*.repo* /etc/yum.repos.d/disabled/
touch /etc/yum.repos.d/centos9-local.repo
cat > /etc/yum.repos.d/centos9-local.repo <<EOF
[Local-BaseOS]
name=CentOS 9 - BaseOS
metadata_expire=-1
gpgcheck=1
enabled=1
baseurl=file:///var/www/html/repos/centos9/BaseOS/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[Local-AppStream]
name=CentOS 9 - AppStream
metadata_expire=-1
gpgcheck=1
enabled=1
baseurl=file:///var/www/html/repos/centos9/AppStream/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF
yum clean all
yum repolist all

echo "The yum/dnf local repoisoty is setup and the Data volume is mounted persistently"



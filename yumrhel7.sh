#/bin/bash
mkdir -p /var/www/html/repos/rhel7
sed -i -e '$aUUID=14b10440-f798-4855-8b33-9ea5d035e163 /var/www/html/repos ext4 defaults        0 0' /etc/fstab
mount -a
mkdir -p /etc/yum.repos.d/disabled/
mv /etc/yum.repos.d/*.repo* /etc/yum.repos.d/disabled/
touch /etc/yum.repos.d/rhel7-local.repo
cat > /etc/yum.repos.d/rhel7-local.repo <<EOF
[Local-BaseOS] 
name=Red Hat Enterprise Linux 7 - BaseOS 
metadata_expire=-1 
gpgcheck=0
enabled=1 
baseurl=file:///var/www/html/repos/rhel7/ 
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF
yum clean all
yum repolist all

echo "The yum/dnf local repoisoty is setup and the Data volume is mounted persistently"
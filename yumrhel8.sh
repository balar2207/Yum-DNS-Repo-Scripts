#/bin/bash
mkdir -p /var/www/html/repos/rhel8
sed -i -e '$aUUID=9d2b484c-286e-4382-b610-796571f35229 /var/www/html/repos ext4 defaults        0 0' /etc/fstab
mount -a
mkdir -p /etc/yum.repos.d/disabled/
mv /etc/yum.repos.d/*.repo* /etc/yum.repos.d/disabled/
touch /etc/yum.repos.d/rhel8-local.repo
cat > /etc/yum.repos.d/rhel8-local.repo <<EOF
[Local-BaseOS] 
name=Red Hat Enterprise Linux 8 - BaseOS 
metadata_expire=-1 
gpgcheck=0 
enabled=1 
baseurl=file:///var/www/html/repos/rhel8/BaseOS/ 
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release 
  

[Local-AppStream] 
name=Red Hat Enterprise Linux 8 - AppStream 
metadata_expire=-1 
gpgcheck=0 
enabled=1 
baseurl=file:///var/www/html/repos/rhel8/AppStream/ 
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release 
EOF
awk '{gsub(/1/,"0")}1' /etc/yum/pluginconf.d/subscription-manager.conf
yum clean all
yum repolist all

echo "The yum/dnf local repoisoty is setup and the Data volume is mounted persistently"

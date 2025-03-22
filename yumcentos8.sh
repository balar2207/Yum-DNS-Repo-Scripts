#/bin/bash
mkdir -p /var/www/html/repos/centos8
sed -i -e '$aUUID=79933ce6-80a5-457e-bd13-30033a472414 /var/www/html/repos ext4 defaults        0 0' /etc/fstab
mount -a
mkdir -p /etc/yum.repos.d/disabled/
mv /etc/yum.repos.d/*.repo* /etc/yum.repos.d/disabled/
touch /etc/yum.repos.d/centos8-local.repo
cat > /etc/yum.repos.d/centos8-local.repo <<EOF
[Local-BaseOS] 
name=CentOS 8 - BaseOS 
gpgcheck=0 
enabled=1 
baseurl=file:///var/www/html/repos/centos8/BaseOS/ 
 

[Local-AppStream] 
name=CentOS 8 - AppStream 
gpgcheck=0
enabled=1 
baseurl=file:///var/www/html/repos/centos8/AppStream/
EOF
yum clean all
yum repolist all

echo "The yum/dnf local repoisoty is setup and the Data volume is mounted persistently"
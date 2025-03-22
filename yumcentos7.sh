#/bin/bash
mkdir -p /var/www/html/repos/centos7
sed -i -e '$aUUID=5985b5cb-c85b-41bc-abe9-c0b313c1c3c1 /var/www/html/repos ext4 defaults        0 0' /etc/fstab
mount -a
mkdir -p /etc/yum.repos.d/disabled/
mv /etc/yum.repos.d/*.repo* /etc/yum.repos.d/disabled/
touch /etc/yum.repos.d/centos7-local.repo
cat > /etc/yum.repos.d/centos7-local.repo <<EOF
[centos7-local] 
name=CentOS 7 Local-Repository 
gpgcheck=0 
enabled=1 
baseurl=file:///var/www/html/repos/centos7
EOF
yum clean all
yum repolist all

echo "The yum/dnf local repoisoty is setup and the Data volume is mounted persistently"
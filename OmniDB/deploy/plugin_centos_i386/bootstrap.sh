#!/bin/bash

PROVISIONED_ON=/etc/vm_provision_on_timestamp
if [ -f "$PROVISIONED_ON" ]
then
  echo "VM was already provisioned at: $(cat $PROVISIONED_ON)"
  echo "To run system updates manually login via 'vagrant ssh' and run 'apt-get update && apt-get upgrade'"
  exit
fi

# Update package list and upgrade all packages
yum -y update

# Install EPEL repo
yum -y install epel-release

# Install dependencies
yum install -y gcc gcc-c++ make git patch rpm-build

# Install PGDG repos
rpm -ivh https://download.postgresql.org/pub/repos/yum/9.3/redhat/rhel-6-i386/pgdg-centos93-9.3-3.noarch.rpm
rpm -ivh https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-6-i386/pgdg-centos94-9.4-3.noarch.rpm
rpm -ivh https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-6-i386/pgdg-centos95-9.5-3.noarch.rpm

# Update
yum -y check-update

# Install PostgreSQL
yum -y install postgresql93 postgresql93-server postgresql93-libs postgresql93-contrib postgresql93-devel
yum -y install postgresql94 postgresql94-server postgresql94-libs postgresql94-contrib postgresql94-devel
yum -y install postgresql95 postgresql95-server postgresql95-libs postgresql95-contrib postgresql95-devel

echo "Cloning OmniDB repo..."
rm -rf ~/OmniDB
git clone --depth 1 --branch dev https://github.com/OmniDB/OmniDB ~/OmniDB
echo "Done"

echo "Building..."
cd ~/OmniDB/OmniDB/deploy/plugin_centos_i386/
./build.sh
echo "Done"

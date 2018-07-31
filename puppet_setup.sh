#!/usr/bin/env bash

BOOTSTRAP_ENV="bootstrap"
ENV_PATH="/etc/puppetlabs/code/environments/${BOOTSTRAP_ENV}"

rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# for mod_passenger
#yum install epel-release
# Removing some of the server-specific things, because those can be added by the bootstrap
# yum install mod_passenger puppetdb puppet-dashboard mariadb-server mod_ssl

yum install git puppetserver  
# TODO if check this
if [ -e "${ENV_PATH}" ]; then
	rm -rf "${ENV_PATH}"
fi

mkdir "${ENV_PATH}"

# TODO come up with some good way for modules with dependencies (that thus 
# shouldn't just be git submodule'd) to be regularly checked for updates

git clone --recursive "https://github.com/hunnybear/hb_puppet.git" "/etc/puppetlabs/code/environments/${BOOTSTRAP_ENV}"
puppet module install --environment "$BOOTSTRAP_ENV" puppet-hiera
puppet module install --environment "$BOOTSTRAP_ENV" theforeman-puppet
puppet module install --environment "$BOOTSTRAP_ENV" theforeman-git
puppet module install --environment "$BOOTSTRAP_ENV" stahnma-epel --version 1.3.1

# WIP, eventually remove noop
puppet apply --noop --environment bootstrap -e "include role_puppetmaster::bootstrap" --show_diff
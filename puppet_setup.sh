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

git clone "h6x6nmark@tylerjachetta.net:/home/h6x6nmark/git/hb_puppet" "/etc/puppetlabs/code/environments/${BOOTSTRAP_ENV}"
puppet module install --environment "$BOOTSTRAP_ENV" puppet-hiera
puppet module install --environment "$BOOTSTRAP_ENV" theforeman-puppet
puppet module install --environment "$BOOTSTRAP_ENV" theforeman-git

# WIP
# puppet agent --environment "${BOOTSTRAP_ENV}" 
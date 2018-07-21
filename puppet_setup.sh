#!/usr/bin/env bash

$BOOTSTRAP_ENV="bootstrap"

rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum install git puppetserver mod_passenger mod_ssl puppetdb puppet-dashboard mariadb-server
# TODO if check this
mkdir "/etc/puppetlabs/code/environments/${BOOTSTRAP_ENV}"
git clone "h6x6nmark@tylerjachetta.net:/home/h6x6nmark/git/hb_puppet" "/etc/puppetlabs/code/environments/${BOOTSTRAP_ENV}/modules/hb_puppet"
puppet module install --environment $BOOTSTRAP_ENV puppet-hiera
puppet module install --environment $BOOTSTRAP_ENV theforeman-puppet
puppet module install --environment $BOOTSTRAP_ENV theforeman-git

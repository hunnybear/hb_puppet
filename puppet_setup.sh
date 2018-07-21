#!/usr/bin/env bash

rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum install git puppetserver mod_passenger mod_ssl puppetdb puppet-dashboard mariadb-server
puppet module install puppet-hiera
puppet module install theforeman-puppet
puppet module install theforeman-git
git clone h6x6nmark@tylerjachetta.net:/home/h6x6nmark/git/hb_puppet 
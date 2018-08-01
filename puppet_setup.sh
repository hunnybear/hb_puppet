#!/usr/bin/env bash

BOOTSTRAP_ENV="bootstrap"
ENV_PATH="/etc/puppetlabs/code/environments/${BOOTSTRAP_ENV}"

function setup_env() {
	local start_wd=$(pwd)
	local status_res

	if [ -e "${ENV_PATH}" ]; then
		cd "$ENV_PATH"
		git status "$ENV_PATH"
		status_res=$?

		if [[ $status_res -ne 0 ]]; then
			cd ..
			rm -rf "${ENV_PATH}"
		else
			# TODO drive with argument
			git pull
		fi
	else
		mkdir "${ENV_PATH}"
	fi

	cd $start_wd

	# TODO come up with some good way for modules with dependencies (that thus 
	# shouldn't just be git submodule'd) to be regularly checked for updates

	git clone --recursive "https://github.com/hunnybear/hb_puppet.git" "/etc/puppetlabs/code/environments/${BOOTSTRAP_ENV}"
	puppet module install --environment "$BOOTSTRAP_ENV" puppet-hiera
	puppet module install --environment "$BOOTSTRAP_ENV" theforeman-puppet
	puppet module install --environment "$BOOTSTRAP_ENV" theforeman-git
	puppet module install --environment "$BOOTSTRAP_ENV" stahnma-epel --version 1.3.1

}


function main() {
	local OPTARG
	local OPTIND
	local option

	local noop=0
	local show_diff=1

	while getopts 'nhD' option; do
		case "$option" in
			"n") noop=1;;
			"D") show_diff=0;;
			"h") usage;exit;;
			?)
				echo "$argv[0]: Bad option specified, quitting"
				usage
				exit 1
			;;
		esac
	done

	rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

	# for mod_passenger
	#yum install epel-release
	# Removing some of the server-specific things, because those can be added by the bootstrap
	# yum install mod_passenger puppetdb puppet-dashboard mariadb-server mod_ssl

	yum install git puppetserver

	setup_env

	# WIP, eventually remove noop
	FACTER_bootstrap=true
	FACTER_role=puppetmaster
	apply_args="--environment ${BOOTSTRAP_ENV}"
	if [[ $noop -ne 0 ]]; then
		apply_args="${apply_args} --noop"
	fi
	if [[ $show_diff -ne 0 ]]; then
		apply_args="${apply_args} --show_diff"
	fi 	
	puppet apply ${apply_args} -e "include role_puppetmaster::bootstrap"

}

main "$@"



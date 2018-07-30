#!/usr/bin/env bash

# For Facter to parse the output, the script must return key/value pairs on STDOUT in the format:

# key1=value1
# key2=value2
# key3=value3

readonly CODEDIR_KEY='codedir'
readonly CONFDIR_KEY='confdir'

readonly FACT_PUPPET_CONFDIR='fact_puppet_confdir'

function print_puppet_conf_fact() {
	local fact_key = $1
	local conf_key = $2
	local val

	if [-z $conf_key ]; then
		>&2 echo "print_puppet_conf_fact requires two arguments! [fact key and conf key]"
		exit 2
	fi

	val=$(puppet conf print "${conf_key}")
	echo "${fact_key}=${val}"
}

print_puppet_conf_fact $FACT_PUPPET_CONFDIR $CONFDIR_KEY


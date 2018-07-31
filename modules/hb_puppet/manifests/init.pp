class hb_puppet() {
	include hb_python

	if $bootstrap {
		# setup puppet config only
		class {'puppet':
			server					=> false,
			agent					=> false,
			server_external_nodes	=> "puppet_enc"
		}
	} else {
		include puppet
	}

	# TODO datafy url
	python::pip{'puppet_tools':
		url		=> 'git+https://github.com/hunnybear/puppet_tools.git',
		require	=> Class['hb_python'],
	}

}
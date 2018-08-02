class hb_puppet(
	$bootstrap_puppet_config={'server'=>false, 'agent'=>false}
	$bootstrap_hiera_config={}
) {
	include hb_python

	if $::bootstrap {
		# setup puppet config only
		class {'puppet':
			* => $bootstrap_puppet_config
		}

		class {'hiera':
			* => $bootstrap_hiera_config
		}

	} else {
		include puppet
		include hiera
	}


	# TODO datafy url
	# TODO figure out whether I can work my way around doing the hb_python (the
	# real needed require is Package[pip], but either way) require every time I 
	# want to install a pip module. I think this is a global resource default,
	# in site.pp.
	python::pip{'puppet_tools':
		url		=> 'git+https://github.com/hunnybear/puppet_tools.git',
		require	=> Class['hb_python'],
	}

}
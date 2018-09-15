class hb_puppet::master() {

	include hb_python

	# TODO allow configuration here if needed (might want to use non-https option)
	include hb_puppet::master::passenger
	include hiera

	include hb_puppet::core

	# TODO datafy url
	# TODO figure out whether I can work my way around doing the hb_python (the
	# real needed require is Package[pip], but either way) require every time I 
	# want to install a pip module. I think this is a global resource default,
	# in site.pp.
	# This might also be worth putting misc tools in a separate subclass, just
	# because I like making subclasses that serve no apparent purpose other 
	# than keeping my files short.
	python::pip{'puppet_tools':
		url		=> 'git+https://github.com/hunnybear/puppet_tools.git',
		require	=> Class['hb_python'],
	}

}
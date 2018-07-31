class hb_python() {
	include puppet
	include hb_python

	# TODO datafy url
	python::pip{'puppet_tools':
		url	=> 'git+https://github.com/hunnybear/puppet_tools.git'
	}
}
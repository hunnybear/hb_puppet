class hb_puppet() {
	include puppet
	include hb_python

	python::pip{ 'hb_lib':
		# TODO better ensure/versioning
		ensure	=> present,	
		url		=> 'git+https://github.com/hunnybear/py_libs.git'
	}
}
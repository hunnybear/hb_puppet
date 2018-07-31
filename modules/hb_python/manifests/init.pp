class hb_python() {
	include python

	python::pip{ 'hb_lib':
		# TODO better ensure/versioning
		ensure	=> present,	
		url		=> 'git+https://github.com/hunnybear/py_libs.git'
	}
}
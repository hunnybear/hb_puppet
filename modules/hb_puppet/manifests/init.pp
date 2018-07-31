class hb_puppet() {
	include python

	python::pip{ 'hb_lib':
		# TODO better ensure/versioning
		ensure	=> present,
		
	}
}
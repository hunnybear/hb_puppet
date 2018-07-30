class hb_puppet::enc($path=hiera("puppet::server_external_nodes", undef)) {
	include python

	# TODO do a git clone and then pip -e install for now
	# TODO after getting that to work, figure out how to actually just get the 
	#		git package artifacts

}
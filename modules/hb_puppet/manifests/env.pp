define hb_puppet::env($source, $update=true) {
	puppet::server::env{$name:}

	# TODO git fetch or update or whatnot
}
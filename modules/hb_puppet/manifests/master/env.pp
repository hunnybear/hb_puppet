define hb_puppet::master::env($source, $update=true) {

	puppet::server::env{$name:}

	# TODO git fetch or update or whatnot
}
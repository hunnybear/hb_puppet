class hb_puppet::enc($path=hiera("puppet::server_external_nodes", undef)) {
	$resolved_path = $path ? {
		undef	=> $name,
		default	=> $path,
	}
}
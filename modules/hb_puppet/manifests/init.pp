class hb_puppet(
	$bootstrap_puppet_config={'server'=>false, 'agent'=>false},
	$bootstrap_hiera_config={}
) {
	
	include hb_puppet::core
}
class role_puppetmaster() {

	include role_base
	include hb_puppet::master
	include hiera

}
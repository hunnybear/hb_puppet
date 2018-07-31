# class to directly include to set up a puppetmaster so it can
# bootstrap into a working puppetmaster.

class role_puppetmaster::bootstrap() {

	include hb_puppet

	# setup puppet config
	class {'puppet':
		server					=> false,
		agent					=> false,
		server_external_nodes	=> ""
	}

	# This is copied from the roles/puppetmaster.json
	$enc_path = "${::puppet::dir}/puppet_enc.py"

		
}
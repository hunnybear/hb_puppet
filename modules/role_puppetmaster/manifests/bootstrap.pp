# class to directly include to set up a puppetmaster so it can
# bootstrap into a working puppetmaster.

class role_puppetmaster::bootstrap() {

	include hb_puppet

	# This is copied from the roles/puppetmaster.json
	$enc_path = "${::puppet::dir}/puppet_enc.py"

		
}
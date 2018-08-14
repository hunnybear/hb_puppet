node default {
	if $::bootstrap{
		$role = 'puppetmaster'
	}
	if $role {
			include "role_${role}"
	}
}
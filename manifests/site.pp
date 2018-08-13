node default {
	if $::bootstrap{
		$role = 'puppetmaster'
	} else {
		if $role {
			include "role_${role}"
		}
	}
}
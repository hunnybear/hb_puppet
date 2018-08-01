node default {
	if not $bootstrap{
		if $role {
			include "role_${role}"
		}
	}
}
node default {
	if $role {
		include "role_${role}"
	}
}
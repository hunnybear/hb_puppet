node default {
	if $role {
		include "role_${role}"
	} else {
		Notify{'No role found! [in site.pp]':}
	}
}
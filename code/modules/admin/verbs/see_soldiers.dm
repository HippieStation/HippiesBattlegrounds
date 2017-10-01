/client/proc/see_soldiers()
	set name = "See Soldiers"
	set category = "WW2 (Admin)"

	if(!check_rights(R_MOD))
		src << "<span class = 'danger'>You don't have the permissions.</span>"
		return

	var/i2faction[3]
	i2faction[1] = GERMAN
	i2faction[2] = RUSSIAN
	i2faction[3] = PARTISAN

	for (var/i in 1 to 3)
		var/faction = i2faction[i]
		src << "<i># of [faction] spies:</i> <b>[spies[faction]]</b>"
		src << "<i># of [faction] officers:</i> <b>[officers[faction]]</b>"
		src << "<i># of [faction] commanders:</i> <b>[commanders[faction]]</b>"
		src << "<i># of [faction] SLs:</i> <b>[squad_leaders[faction]]</b>"
		src << "<i># of [faction] soldats in squads:</i> <b>[squad_members[faction]]</b>"
		src << "<i># of [faction] total soldats:</i> <b>[soldiers[faction]]</b>"

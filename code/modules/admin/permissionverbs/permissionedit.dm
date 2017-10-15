/client/proc/edit_admin_permissions()
	set category = "Admin"
	set name = "Permissions Panel"
	set desc = "Edit admin permissions"
	if(!check_rights(R_PERMISSIONS))	return
	usr.client.holder.edit_admin_permissions()

/datum/admins/proc/edit_admin_permissions()
	if(!check_rights(R_PERMISSIONS))	return

	var/output = {"<!DOCTYPE html>
<html>
<head>
<title>Permissions Panel</title>
<script type='text/javascript' src='search.js'></script>
<link rel='stylesheet' type='text/css' href='panels.css'>
</head>
<body onload='selectTextField();updateSearch();'>
<div id='main'><table id='searchable' cellspacing='0'>
<tr class='title'>
<th style='width:125px;text-align:right;'>CKEY <a class='small' href='?src=\ref[src];editrights=add'>\[+\]</a></th>
<th style='width:125px;'>RANK</th><th style='width:100%;'>PERMISSIONS</th>
</tr>
"}

	for(var/adm_ckey in admin_datums)
		var/datum/admins/D = admin_datums[adm_ckey]
		if(!D)	continue
		var/rank = D.rank ? D.rank : "*none*"
		var/rights = rights2text(D.rights," ")
		if(!rights)	rights = "*none*"

		output += "<tr>"
		output += "<td style='text-align:right;'>[adm_ckey] <a class='small' href='?src=\ref[src];editrights=remove;ckey=[adm_ckey]'>\[-\]</a></td>"
		output += "<td><a href='?src=\ref[src];editrights=rank;ckey=[adm_ckey]'>[rank]</a></td>"
		output += "<td><a class='small' href='?src=\ref[src];editrights=permissions;ckey=[adm_ckey]'>[rights]</a></td>"
		output += "</tr>"

	output += {"
</table></div>
<div id='top'><b>Search:</b> <input type='text' id='filter' value='' style='width:70%;' onkeyup='updateSearch();'></div>
</body>
</html>"}

	usr << browse(output,"window=editrights;size=600x500")

// see admin/topic.dm
/datum/admins/proc/log_admin_rank_modification(var/adm_ckey, var/new_rank)

	if(!usr.client)
		return

	if(!usr.client.holder || !(usr.client.holder.rights & R_PERMISSIONS))
		usr << "\red You do not have permission to do this!"
		return

	establish_db_connection()

	if(!database)
		usr << "\red Failed to establish database connection"
		return

	if(!adm_ckey || !new_rank)
		return

	adm_ckey = ckey(adm_ckey)

	if(!adm_ckey)
		return

	if(!istext(adm_ckey) || !istext(new_rank))
		return

	var/list/rowdata = database.execute("SELECT id FROM erro_admin WHERE ckey = '[adm_ckey]';")

	var/new_admin = 1
	var/admin_id

	if (islist(rowdata) && !isemptylist(rowdata))
		new_admin = 0
		admin_id = text2num(rowdata["id"])

	if(new_admin)
		database.execute("INSERT INTO erro_admin (id, ckey, rank, flags) VALUES (null, '[adm_ckey]', '[new_rank]', 0)")
		message_admins("[key_name_admin(usr)] made [key_name_admin(adm_ckey)] an admin with the rank [new_rank]")
		log_admin("[key_name(usr)] made [key_name(adm_ckey)] an admin with the rank [new_rank]")
		usr << "\blue New admin added."
	else
		if(!isnull(admin_id) && isnum(admin_id))
			database.execute("UPDATE erro_admin SET rank = '[new_rank]' WHERE id = '[admin_id]'")
			message_admins("[key_name_admin(usr)] changed [key_name_admin(adm_ckey)] admin rank to [new_rank]")
			log_admin("[key_name(usr)] changed [key_name(adm_ckey)] admin rank to [new_rank]")
			usr << "\blue Admin rank changed."

// see admin/topic.dm
/datum/admins/proc/log_admin_permission_modification(var/adm_ckey, var/new_permission, var/nominal)

	if(!usr.client)
		return

	if(!usr.client.holder || !(usr.client.holder.rights & R_PERMISSIONS))
		usr << "\red You do not have permission to do this!"
		return

	establish_db_connection()

	if(!database)
		usr << "\red Failed to establish database connection"
		return

	if(!adm_ckey || !new_permission)
		return

	adm_ckey = ckey(adm_ckey)

	if(!adm_ckey)
		return

	if(istext(new_permission))
		new_permission = text2num(new_permission)

	if(!istext(adm_ckey) || !isnum(new_permission))
		return

	var/list/rowdata = database.execute("SELECT id, flags FROM erro_admin WHERE ckey = '[adm_ckey]';")

	var/admin_id
	var/admin_rights

	if (islist(rowdata) && !isemptylist(rowdata))
		admin_id = text2num(rowdata["id"])
		admin_rights = text2num(rowdata["flags"])

	if(!admin_id)
		return

	if(admin_rights & new_permission) //This admin already has this permission, so we are removing it.
		database.execute("UPDATE erro_admin SET flags = '[admin_rights & ~new_permission]' WHERE id = '[admin_id]'")
		message_admins("[key_name_admin(usr)] removed the [nominal] permission of [key_name_admin(adm_ckey)]")
		log_admin("[key_name(usr)] removed the [nominal] permission of [key_name(adm_ckey)]")
		usr << "\blue Permission removed."
	else //This admin doesn't have this permission, so we are adding it.
		database.execute("UPDATE erro_admin SET flags = '[admin_rights | new_permission]' WHERE id = '[admin_id]'")
		message_admins("[key_name_admin(usr)] added the [nominal] permission of [key_name_admin(adm_ckey)]")
		log_admin("[key_name(usr)] added the [nominal] permission of [key_name(adm_ckey)]")
		usr << "\blue Permission added."
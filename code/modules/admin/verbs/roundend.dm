/client/proc/trigger_roundend()
	set name = "End the round"
	set category = "Server"

	if(!check_rights(R_SERVER))
		src << "<span class = 'danger'>You don't have the permissions.</span>"
		return
	if (!istype(ticker.mode, /datum/game_mode/ww2))
		src << "<span class = 'danger'>Hey dick, you aren't allowed to end this type of gamemode.</span>"
		return

	var/conf_1 = input("Are you absolutely positively sure you want to END THE ROUND?") in list ("Yes", "No")
	if (conf_1 == "No")
		return
	var/conf_2 = input("Seriously?") in list ("Yes", "No")
	if (conf_2 == "No")
		return

	var/datum/game_mode/ww2/WW2 = ticker.mode
	WW2.admins_triggered_roundend = 1

	message_admins("[key_name(src)] ended the round!")
	log_admin("[key_name(src)] ended the round!")
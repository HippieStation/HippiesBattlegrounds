/datum/game_mode/ww2
	name = "World War 2"
	config_tag = "ww2"
	required_players = 0
	round_description = ""
	extended_round_description = ""
	var/time_both_sides_locked = -1
	var/german_win_coeff = 1.1 // germans gets S.S.
	var/soviet_win_coeff = 1.0 // and soviets don't

/datum/game_mode/ww2/check_finished()
	if (..())
		return 1
	else
		if (time_both_sides_locked != -1)
			if ((time_both_sides_locked - world.realtime) > 7500)
				if (WW2_soldiers_en_ru_ratio() >= german_win_coeff) // germans win
					return 1
				else if (WW2_soldiers_en_ru_ratio() <= soviet_win_coeff) // soviets win
					return 1
				else // between 1.0 and 1.1
					return 1
		else if (reinforcements_master.is_permalocked("GERMAN"))
			if (reinforcements_master.is_permalocked("RUSSIAN"))
				time_both_sides_locked = world.realtime
				world << "<font size = 3>The game will end in 15 minutes.</font>"

/datum/game_mode/ww2/declare_completion()
	var/list/soldiers = WW2_soldiers_alive()
	var/WW2_soldiers_en_ru_coeff = WW2_soldiers_en_ru_ratio()

	var/winning_side = ""
	if (WW2_soldiers_en_ru_coeff >= german_win_coeff)
		winning_side = "German Army"
	else if (WW2_soldiers_en_ru_coeff <= soviet_win_coeff)
		winning_side = "Soviet Army"
	else
		winning_side = null

	var/text = ""
	text += "[soldiers["en"]] Wehrmacht and S.S. soldiers survived.<br>"
	text += "[soldiers["ru"]] Soviet soldiers survived.<br><br>"
	if (winning_side)
		text += "<big><span class = 'danger'>The [winning_side] wins!</span></big>"
	else
		text += "<big><span class = 'danger'>Neither side wins.</span></big>"
	world << text

/datum/game_mode/ww2/announce() //to be called when round starts
	world << "<b>The current game mode is World War II!</b>"

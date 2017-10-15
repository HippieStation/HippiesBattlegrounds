// aspect datums determine random aspects of a game mode

#define WW2_ASPECT_SPAN "<span class = 'notice' style = 'font-size: 2.0em;'>"
#define WW2_ASPECTDESC_SPAN "<span class = 'notice' style = 'font-size: 1.33em;'>"

/datum/game_aspect
	var/game_mode_type = null
	var/default_aspect_type = null
	var/default_aspect_chance = 25
	var/list/possible_subtypes = list()
	var/datum/game_mode/mode = null
	var/desc = ""
	var/required_clients = 0
	var/list/real_aspects = list()

/datum/game_aspect/New(var/datum/game_mode/M)
	..()
	if (M) // if we don't pass an arg, this code is ommitted. Intentional.
		if (!game_mode_type || !default_aspect_type || !possible_subtypes.len)
			qdel(src)
			return

		for (var/aspecttype in possible_subtypes)
			var/datum/game_aspect/A = new aspecttype
			if (A && clients.len >= A.required_clients)
				real_aspects += A

		if (prob(100 - default_aspect_chance))
			M.aspect = pick(real_aspects)
		else
			M.aspect = new default_aspect_type

		M.aspect.mode = M

		for (var/x in real_aspects)
			if (x != M.aspect)
				qdel(x)

/datum/game_aspect/proc/activate()
	if (!mode)
		return 0
	return "The current aspect is: "

/datum/game_aspect/proc/post_activation()
	return 1

// immediate subtypes of the aspect datum

/datum/game_aspect/ww2
	game_mode_type = /datum/game_mode/ww2
	default_aspect_type = /datum/game_aspect/ww2/default
	possible_subtypes = list(/datum/game_aspect/ww2/german_padvantage,
		/datum/game_aspect/ww2/german_pdisadvantage,
		/datum/game_aspect/ww2/russian_padvantage,
		/datum/game_aspect/ww2/russian_pdisadvantage,

		/datum/game_aspect/ww2/german_sadvantage,
		/datum/game_aspect/ww2/german_sdisadvantage,
		/datum/game_aspect/ww2/russian_sadvantage,
		/datum/game_aspect/ww2/russian_sdisadvantage,

		/datum/game_aspect/ww2/german_logistical_disadvantage)

/datum/game_aspect/ww2/post_activation()

	var/datum/game_mode/ww2/mymode = mode
	// make both sides' personnel at least 1.0

	if (!mymode.personnel[GERMAN])
		mymode.personnel[GERMAN] = 1.0

	if (!mymode.personnel[RUSSIAN])
		mymode.personnel[RUSSIAN] = 1.0

	// make both sides' supplies at least 1.0

	if (!mymode.supplies[GERMAN])
		mymode.supplies[GERMAN] = 1.0

	if (!mymode.supplies[RUSSIAN])
		mymode.supplies[RUSSIAN] = 1.0

// subtypes of /datum/game_aspect/ww2

/datum/game_aspect/ww2/default
	desc = "Nothing is out of the ordinary this round."
	required_clients = 0

/datum/game_aspect/ww2/default/activate()
	. = ..()
	if (. == FALSE)
		return .
	world << "[WW2_ASPECT_SPAN][.]None</span>"
	world << "<br><i>[desc]</i>"

/datum/game_aspect/ww2/german_padvantage
	desc = "The German Wehrmacht outnumbers the Red Army this round."
	required_clients = 20

/datum/game_aspect/ww2/german_padvantage/activate()
	. = ..()
	if (. == FALSE)
		return .
	world << "[WW2_ASPECT_SPAN][.]German Personnel Advantage!</span>"
	world << "<br><i>[desc]</i>"
	var/datum/game_mode/ww2/mymode = mode
	mymode.personnel[GERMAN] = random_decimal(1.1,1.2)

/datum/game_aspect/ww2/german_pdisadvantage
	desc = "The German Wehrmacht has a severe lack of men this round."
	required_clients = 20

/datum/game_aspect/ww2/german_pdisadvantage/activate()
	. = ..()
	if (. == FALSE)
		return .
	world << "[WW2_ASPECT_SPAN][.]German Personnel Disadvantage!</span>"
	world << "<br><i>[desc]</i>"
	var/datum/game_mode/ww2/mymode = mode
	mymode.personnel[GERMAN] = random_decimal(0.8,0.9)

/datum/game_aspect/ww2/russian_padvantage
	desc = "The Red Army outnumbers the German Wehrmacht this round."
	required_clients = 20

/datum/game_aspect/ww2/russian_padvantage/activate()
	. = ..()
	if (. == FALSE)
		return .
	world << "[WW2_ASPECT_SPAN][.]Soviet Personnel Advantage!</span>"
	world << "<br><i>[desc]</i>"
	var/datum/game_mode/ww2/mymode = mode
	mymode.personnel[RUSSIAN] = random_decimal(1.1,1.2)

/datum/game_aspect/ww2/russian_pdisadvantage
	desc = "The Red Army has a severe lack of men this round."
	required_clients = 20

/datum/game_aspect/ww2/russian_pdisadvantage/activate()
	. = ..()
	if (. == FALSE)
		return .
	world << "[WW2_ASPECT_SPAN][.]Soviet Personnel Disadvantage!</span>"
	world << "<br><i>[desc]</i>"
	var/datum/game_mode/ww2/mymode = mode
	mymode.personnel[RUSSIAN] = random_decimal(0.8,0.9)

/datum/game_aspect/ww2/german_sadvantage
	desc = "The German Wehrmacht has extra supply points this round."

/datum/game_aspect/ww2/german_sadvantage/activate()
	. = ..()
	if (. == FALSE)
		return .
	world << "[WW2_ASPECT_SPAN][.]German Supply Advantage!</span>"
	world << "<br><i>[desc]</i>"
	var/datum/game_mode/ww2/mymode = mode
	mymode.supplies[GERMAN] = random_decimal(1.1,1.2)

/datum/game_aspect/ww2/german_sdisadvantage
	desc = "The German Wehrmacht is under-supplied this round."

/datum/game_aspect/ww2/german_sdisadvantage/activate()
	. = ..()
	if (. == FALSE)
		return .
	world << "[WW2_ASPECT_SPAN][.]German Supply Disadvantage!</span>"
	world << "<br><i>[desc]</i>"
	var/datum/game_mode/ww2/mymode = mode
	mymode.supplies[GERMAN] = random_decimal(0.8, 0.9)

/datum/game_aspect/ww2/russian_sadvantage
	desc = "The Red Army is very well supplied this round."

/datum/game_aspect/ww2/russian_sadvantage/activate()
	. = ..()
	if (. == FALSE)
		return .
	world << "[WW2_ASPECT_SPAN][.]Soviet Supply Advantage!</span>"
	world << "<br><i>[desc]</i>"
	var/datum/game_mode/ww2/mymode = mode
	mymode.supplies[RUSSIAN] = random_decimal(1.1, 1.2)

/datum/game_aspect/ww2/russian_sdisadvantage
	desc = "The Red Army is under-supplied this round."

/datum/game_aspect/ww2/russian_sdisadvantage/activate()
	. = ..()
	if (. == FALSE)
		return .
	world << "[WW2_ASPECT_SPAN][.]Soviet Supply Disadvantage!</span>"
	world << "<br><i>[desc]</i>"
	var/datum/game_mode/ww2/mymode = mode
	mymode.supplies[RUSSIAN] = random_decimal(0.8, 0.9)

/datum/game_aspect/ww2/german_logistical_disadvantage
	desc = "The German High Command has disallowed sending the train until after 15 minutes for this round."

/datum/game_aspect/ww2/german_logistical_disadvantage/activate()
	. = ..()
	if (. == FALSE)
		return .
	world << "[WW2_ASPECT_SPAN][.]German Logistical Disadvantage!</span>"
	world << "<br><i>[desc]</i>"
	GRACE_PERIOD_LENGTH = 15

#undef WW2_ASPECT_SPAN
#undef WW2_ASPECTDESC_SPAN
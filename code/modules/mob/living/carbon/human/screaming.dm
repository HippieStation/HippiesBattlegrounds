/proc/scream_sound(var/mob/m, var/dying = 0)

	if (!ishuman(m))
		return 0

	if (m.stat == UNCONSCIOUS || m.stat == DEAD)
		return 0

	var/mob/living/carbon/human/H = m

	if (H.gender == MALE)
		playsound(get_turf(H), 'sound/voice/scream_male.ogg', 100)
	else
		playsound(get_turf(H), 'sound/voice/scream_female.ogg', 100)
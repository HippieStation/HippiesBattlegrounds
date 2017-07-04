//ARTILLERY

var/global/list/valid_coordinates = list()
/mob/living/carbon/human/var/checking_coords[4]
/mob/living/carbon/human/var/can_check_distant_coordinates = 0

/mob/living/carbon/human/proc/make_artillery_officer()
	verbs += /mob/living/carbon/human/proc/Check_Coordinates
	verbs += /mob/living/carbon/human/proc/Reset_Coordinates
	can_check_distant_coordinates = 1

/mob/living/carbon/human/proc/make_artillery_scout()
	verbs += /mob/living/carbon/human/proc/Check_Coordinates_Chump
	verbs += /mob/living/carbon/human/proc/Reset_Coordinates_Chump
	can_check_distant_coordinates = 1

/mob/living/carbon/human/proc/Check_Coordinates()
	set category = "Officer"
	if (checking_coords[1] && checking_coords[2])
		checking_coords[3] = x
		checking_coords[4] = y
		valid_coordinates["[x],[y]"] = 1
		var/dist = "[checking_coords[3] - checking_coords[1]],[checking_coords[4] - checking_coords[2]]"
		usr << "<span class = 'notice'>You finished tracking coordinates at <b>[x],[y]</b>. You moved an offset of <b>[dist]</b>. A Kanonier can now fire at this location.</span>"
		checking_coords[3] = null
		checking_coords[4] = null // continue to track from the same starting location
	else
		checking_coords[1] = x
		checking_coords[2] = y
		usr << "<span class = 'notice'>You've started checking coordinates at <b>[x], [y]</b>.</span>"

/mob/living/carbon/human/proc/Reset_Coordinates()
	set category = "Officer"
	if (checking_coords[1] && checking_coords[2])
		var/x = checking_coords[1]
		var/y = checking_coords[2]
		checking_coords[1] = null
		checking_coords[2] = null
		usr << "<span class = 'notice'>You are no longer tracking from <b>[x],[y]</b>.</span>"
		checking_coords[3] = null
		checking_coords[4] = null

// the only thing different about these verbs is the category

/mob/living/carbon/human/proc/Check_Coordinates_Chump()
	set category = "Scout"
	set name = "Check Coordinates"
	if (checking_coords[1] && checking_coords[2])
		checking_coords[3] = x
		checking_coords[4] = y
		valid_coordinates["[x],[y]"] = 1
		var/dist = "[checking_coords[3] - checking_coords[1]],[checking_coords[4] - checking_coords[2]]"
		usr << "<span class = 'notice'>You finished tracking coordinates at <b>[x],[y]</b>. You moved an offset of <b>[dist]</b>. A Kanonier can now fire at this location.</span>"
		checking_coords[3] = null
		checking_coords[4] = null // continue to track from the same starting location
	else
		checking_coords[1] = x
		checking_coords[2] = y
		usr << "<span class = 'notice'>You've started checking coordinates at <b>[x],[y]</b>.</span>"

/mob/living/carbon/human/proc/Reset_Coordinates_Chump()
	set category = "Scout"
	set name = "Reset Coordinates"
	if (checking_coords[1] && checking_coords[2])
		var/x = checking_coords[1]
		var/y = checking_coords[2]
		checking_coords[1] = null
		checking_coords[2] = null
		usr << "<span class = 'warning'>You are no longer tracking from <b>[x],[y]</b>.</span>"
		checking_coords[3] = null
		checking_coords[4] = null

// artyman/officer/scout getting coordinates
/mob/living/carbon/human/RangedAttack(var/turf/simulated/t)
	if (checking_coords[1] && istype(t))
		if (can_check_distant_coordinates && get_turf(src) != t)
			var/offset_x = t.x - x
			var/offset_y = t.y - y
			src << "<span class = 'notice'>This turf has an offset of <b>[offset_x],[offset_y]</b> and coordinates of <b>[t.x],[t.y]</b>. A Kanonier can now fire at this location.</span>"
			valid_coordinates["[t.x],[t.y]"] = 1
	else
		return ..()

//OTHER

//WIP - I need sounds - Kachnov
/mob/living/carbon/human/proc/officer_command_attack()
	var/job_type = null
	if (istype(mind.assigned_job, /datum/job/russian))
		job_type = /datum/job/russian
	else if (istype(mind.assigned_job, /datum/job/german))
		job_type = /datum/job/german
	if (!job_type)
		return
	for (var/mob/m in range(10, src))
		if (m.client && ishuman(m))
			var/mob/living/carbon/human/H = m
			if (istype(H.mind.assigned_job, job_type))
				return
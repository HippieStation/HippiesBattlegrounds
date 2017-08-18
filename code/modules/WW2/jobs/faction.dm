
/* Job Factions

 - These are/will be used for spies, partisans, and squads.
 - They're like antagonist datums but much simpler. You can have many
 - different factions depending on your job

 - helper functions are at the bottom

*/

#define TEAM_RU 1
#define TEAM_GE 2
#define TEAM_PN 3

var/global/spies[3]
var/global/officers[3]
var/global/commanders[3]
var/global/squad_leaders[3]
var/global/soldiers[3]
var/global/squad_members[3]

/datum/faction
	// redefine these since they don't exist in /datum
	var/icon = 'icons/mob/hud_WW2.dmi'
	var/icon_state = ""
	var/mob/living/carbon/human/holder = null
	var/title = "Something that shouldn't exist"
	var/list/objectives = list()
	var/team = null
	var/image/last_returned_image = null
	var/obj/factionhud/last_returned_hud = null

/datum/faction/proc/base_type()
	return "/datum/faction"

// you appear to be a partisan to all other partisans
/datum/faction/partisan
	icon_state = "partisan_soldier"
	title = "Partisan Soldier"
	team = TEAM_PN

/datum/faction/partisan/base_type()
	return "/datum/faction/partisan"

// you appear to be an officer to all other partisans (UNUSED)
/datum/faction/partisan/officer
	icon_state = "partisan_officer"
	team = TEAM_PN
// you appear to be a partisan leader to all other partisans
/datum/faction/partisan/commander
	icon_state = "partisan_commander"
	title = "Partisan Leader"
	team = TEAM_PN
// you appear to be a german soldier to all other germans
/datum/faction/german
	icon_state = "german_soldier"
	title = "Wehrmacht Soldier"
	team = TEAM_GE

/datum/faction/german/base_type()
	return "/datum/faction/german"
// you appear to be a SS soldier to all other germans
/datum/faction/german/SS
	icon_state = "ss_soldier"
	title = "SS Soldier"
	team = TEAM_GE
// you appear to be an officer to all other germans
/datum/faction/german/officer
	icon_state = "german_officer"
	title = "Wehrmacht Officer"
	team = TEAM_GE
// you appear to be a german leader to all other germans
/datum/faction/german/commander
	icon_state = "german_commander"
	title = "Feldwebel"
	team = TEAM_GE
// you appear to be a SS leader to all other germans
/datum/faction/german/commander/SS
	icon_state = "ss_commander"
	title = "Feldwebel"
	team = TEAM_GE
// you appear to be a russian soldier to all other russians
/datum/faction/russian
	icon_state = "russian_soldier"
	title = "Russian Soldier"
	team = TEAM_RU

/datum/faction/russian/base_type()
	return "/datum/faction/russian"
// you appear to be an officer to all other russians
/datum/faction/russian/officer
	icon_state = "russian_officer"
	team = TEAM_RU
// you appear to be a russian leader to all other russians
/datum/faction/russian/commander
	icon_state = "russian_commander"
	team = TEAM_RU
// squads: both german and russian use the same types. What squad you appear
// to be in, and to whom, depends on your true faction. Spies

/datum/faction/squad
	var/squad = null
	var/is_leader = 0
	var/number = "#1"
	var/actual_number = 1
	New(var/mob/living/carbon/human/H, var/datum/job/J)

		var/squadmsg = ""

		if (!is_leader)
			squadmsg = "<span class = 'danger'>You've been assigned to squad [squad].[istype(J, /datum/job/german) ? " Meet with the rest of your squad on train car [number]. " : " "]Examine people to see if they're in your squad, or if they're your squad leader."
		else
			squadmsg = "<span class = 'danger'>You are the [J.title] of squad [squad].[istype(J, /datum/job/german) ? " Meet with your squad on train car [number]. " : " "]Examine people to see if they're one of your soldats."

		squadmsg = replacetext(squadmsg, "<span class = 'danger'>", "")
		squadmsg = replacetext(squadmsg, "</span>", "")

		H.add_memory(squadmsg)

		..(H, J)

/datum/faction/squad/one
	icon_state = "squad_one"
	squad = "one"
	number = "#1"
	actual_number = 1
/datum/faction/squad/one/leader
	icon_state = "squad_one_leader"
	is_leader = 1

/datum/faction/squad/two
	icon_state = "squad_two"
	squad = "two"
	number = "#2"
	actual_number = 2
/datum/faction/squad/two/leader
	icon_state = "squad_two_leader"
	is_leader = 1

/datum/faction/squad/three
	icon_state = "squad_three"
	squad = "three"
	number = "#3"
	actual_number = 3
/datum/faction/squad/three/leader
	icon_state = "squad_three_leader"
	is_leader = 1

/datum/faction/squad/four
	icon_state = "squad_four"
	squad = "four"
	number = "#4"
	actual_number = 4
/datum/faction/squad/four/leader
	icon_state = "squad_four_leader"
	is_leader = 1

// spies use normal faction types

// CODE
/datum/faction/New(var/mob/living/carbon/human/H, var/datum/job/J)

	if (!H || !istype(H))
		return

	holder = H

	if (findtext("[type]", "leader"))
		if (istype(J, /datum/job/german))
			squad_leaders[GERMAN]++
		else if (istype(J, /datum/job/russian))
			squad_leaders[RUSSIAN]++
		else if (istype(J, /datum/job/partisan))
			squad_leaders[PARTISAN]++
	else if (findtext("[type]", "officer"))
		if (istype(J, /datum/job/german))
			officers[GERMAN]++
		else if (istype(J, /datum/job/russian))
			officers[RUSSIAN]++
		else if (istype(J, /datum/job/partisan))
			officers[PARTISAN]++
	else if (findtext("[type]", "commander"))
		if (istype(J, /datum/job/german))
			commanders[GERMAN]++
		else if (istype(J, /datum/job/russian))
			commanders[RUSSIAN]++
		else if (istype(J, /datum/job/partisan))
			commanders[PARTISAN]++
	else if (!J.is_officer && !J.is_commander && !J.is_squad_leader)
		if (istype(J, /datum/job/german))
			if ("[type]" == "/datum/faction/german")
				soldiers[GERMAN]++
			else if (findtext("[type]", "squad") && !src:is_leader)
				squad_members[GERMAN]++
		else if (istype(J, /datum/job/russian))
			if ("[type]" == "/datum/faction/russian")
				soldiers[RUSSIAN]++
			else if (findtext("[type]", "squad") && !src:is_leader)
				squad_members[RUSSIAN]++
		else if (istype(J, /datum/job/partisan))
			if ("[type]" == "/datum/faction/partisan")
				soldiers[PARTISAN]++
			else if (findtext("[type]", "squad") && !src:is_leader)
				squad_members[PARTISAN]++
	H.all_factions += src
	..()

/* HELPER FUNCTIONS */

/proc/issquadleader(var/mob/living/carbon/human/H)
	if (H.squad_faction && H.squad_faction.is_leader)
		return 1
	return 0

/proc/issquadmember(var/mob/living/carbon/human/H)
	if (H.squad_faction && !H.squad_faction.is_leader)
		return 1
	return 0

/proc/getsquad(var/mob/living/carbon/human/H)
	if (H.squad_faction)
		return H.squad_faction.squad
	return null

/proc/isgermansquadmember_or_leader(var/mob/living/carbon/human/H)
	return (istype(H.original_job, /datum/job/german) && getsquad(H))

/proc/isgermansquadleader(var/mob/living/carbon/human/H)
	return (istype(H.original_job, /datum/job/german) && issquadleader(H))

/proc/isrussiansquadmember_or_leader(var/mob/living/carbon/human/H)
	return (istype(H.original_job, /datum/job/russian) && getsquad(H))

/proc/isrussiansquadleader(var/mob/living/carbon/human/H)
	return (istype(H.original_job, /datum/job/russian) && issquadleader(H))

/proc/sharesquads(var/mob/living/carbon/human/H, var/mob/living/carbon/human/HH)
	return (getsquad(H) == getsquad(HH) && getsquad(H))

/proc/isleader(var/mob/living/carbon/human/H, var/mob/living/carbon/human/HH)
	if (issquadleader(H) && issquadmember(HH) && getsquad(H) == getsquad(HH))
		return 1
	return 0
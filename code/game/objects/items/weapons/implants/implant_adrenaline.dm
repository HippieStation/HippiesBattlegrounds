/obj/item/weapon/implant/adrenalin
	name = "adrenalin"
	desc = "Removes all stuns and knockdowns."
	var/uses
	origin_tech = list(TECH_MATERIAL=2, TECH_BIO=4, TECH_COMBAT=3, TECH_ILLEGAL=4)

/obj/item/weapon/implant/adrenalin/get_data()
	var/data = {"
		<b>Implant Specifications:</b><BR>
		<b>Name:</b> Cybersun Industries Adrenalin Implant<BR>
		<b>Life:</b> Five days.<BR>
		<b>Important Notes:</b> <font color='red'>Illegal</font><BR>
		<HR>
		<b>Implant Details:</b> Subjects injected with implant can activate a massive injection of adrenalin.<BR>
		<b>Function:</b> Contains nanobots to stimulate body to mass-produce Adrenalin.<BR>
		<b>Special Features:</b> Will prevent and cure most forms of brainwashing.<BR>
		<b>Integrity:</b> Implant can only be used three times before the nanobots are depleted."}
	return data


/obj/item/weapon/implant/adrenalin/trigger(emote, mob/source as mob)
	if (src.uses < 1)	return 0
	if (emote == "pale")
		src.uses--
		source << "<span class='notice'>You feel a sudden surge of energy!</span>"
		source.SetStunned(0)
		source.SetWeakened(0)
		source.SetParalysis(0)

	return

/obj/item/weapon/implant/adrenalin/install(mob/living/carbon/human/H)
	..()
	H.mind.store_memory("A implant can be activated by using the pale emote, <B>say *pale</B> to attempt to activate.", 0, 0)
	H << "The implanted freedom implant can be activated by using the pale emote, <B>say *pale</B> to attempt to activate."


/obj/item/weapon/implantcase/adrenalin
	name = "glass case - 'adrenalin'"
	desc = "A case containing an adrenalin implant."
	icon_state = "implantcase-b"
	implant_type = /obj/item/weapon/implant/adrenalin


/obj/item/weapon/implanter/adrenalin
	name = "implanter-adrenalin"
	implant_type = /obj/item/weapon/implant/adrenalin

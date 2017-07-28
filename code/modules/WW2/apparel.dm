#define SOVIET_UNIFORM_NAME "Soviet uniform"
#define SOVIET_UNIFORM_DESC "Standard soviet uniform for soildiers. You can smell german virgin's blood on it."
#define SOVIET_UNIFORM_STATE "sovuni"

#define GERMAN_UNIFORM_NAME "German uniform"
#define GERMAN_UNIFORM_DESC "Standart german uniform for soildiers. You can smell seiner madchenes parfume!"
#define GERMAN_UNIFORM_STATE "geruni"

#define SOVIET_HELMET_NAME ""
#define SOVIET_HELMET_DESC ""
#define SOVIET_HELMET_STATE ""

#define GERMAN_HELMET_NAME ""
#define GERMAN_HELMET_DESC ""
#define GERMAN_HELMET_STATE ""

/obj/item/clothing/under
	var/swapped = 0

/obj/item/clothing/under/proc/add_alternative_setting()
	verbs += /obj/item/clothing/under/proc/Swap

/obj/item/clothing/under/proc/Swap()
	set category = "Object"
	var/mob/living/carbon/human/m = loc
	if (m && istype(m) && m.is_spy)

		if (name == GERMAN_UNIFORM_NAME)
			transform2soviet()
		else if (name == SOVIET_UNIFORM_NAME)
			transform2german()

		if (istype(src, /obj/item/clothing/under/geruni))
			switch (name)
				if (SOVIET_UNIFORM_NAME)
					m << "<span class = 'danger'>You change back into your original uniform. Long live mother Russia!</span>"
				if (GERMAN_UNIFORM_NAME)
					m << "<span class = 'danger'>You change back into your spy uniform.</span>"
		else if (istype(src, /obj/item/clothing/under/sovuni))
			if (GERMAN_UNIFORM_NAME)
				m << "<span class = 'danger'>You change back into your original uniform. Sieg heil!</span>"
			if (SOVIET_UNIFORM_NAME)
				m << "<span class = 'danger'>You change back into your spy uniform.</span>"

	return 0

/obj/item/clothing/under/proc/transform2soviet()

	name = SOVIET_UNIFORM_NAME
	desc = SOVIET_UNIFORM_DESC
	icon_state = SOVIET_UNIFORM_STATE
	item_state = SOVIET_UNIFORM_STATE
	worn_state = SOVIET_UNIFORM_STATE
	item_state_slots["slot_w_uniform"] = SOVIET_UNIFORM_STATE
	update_clothing_icon()

	var/mob/living/carbon/human/H = loc
	if (istype(H.s_store, /obj/item/device/radio/feldfu))
		var/radio = H.s_store
		H.drop_from_inventory(radio)
		qdel(radio)
		H.equip_to_slot_or_del(new /obj/item/device/radio/rbs(H), slot_s_store)
	if (istype(H.head, /obj/item/clothing/head/helmet/tactical/gerhelm))
		var/head = H.head
		H.drop_from_inventory(head)
		qdel(head)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/tactical/sovhelm(H), slot_head)

/obj/item/clothing/under/proc/transform2german()
	name = GERMAN_UNIFORM_NAME
	desc = GERMAN_UNIFORM_DESC
	icon_state = GERMAN_UNIFORM_STATE
	item_state = GERMAN_UNIFORM_STATE
	worn_state = GERMAN_UNIFORM_STATE
	item_state_slots["slot_w_uniform"] = GERMAN_UNIFORM_STATE
	update_clothing_icon()

	var/mob/living/carbon/human/H = loc
	if (istype(H.s_store, /obj/item/device/radio/rbs))
		var/radio = H.s_store
		H.drop_from_inventory(radio)
		qdel(radio)
		H.equip_to_slot_or_del(new /obj/item/device/radio/feldfu(H), slot_s_store)
	if (istype(H.head, /obj/item/clothing/head/helmet/tactical/sovhelm))
		var/head = H.head
		H.drop_from_inventory(head)
		qdel(head)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/tactical/gerhelm(H), slot_head)


/obj/item/clothing/under/sovuni
	name = SOVIET_UNIFORM_NAME
	desc = SOVIET_UNIFORM_DESC
	icon_state = SOVIET_UNIFORM_STATE
	item_state = SOVIET_UNIFORM_STATE
	worn_state = SOVIET_UNIFORM_STATE

/obj/item/clothing/under/geruni
	name = GERMAN_UNIFORM_NAME
	desc = GERMAN_UNIFORM_DESC
	icon_state = GERMAN_UNIFORM_STATE
	item_state = GERMAN_UNIFORM_STATE
	worn_state = GERMAN_UNIFORM_STATE
	var/rolled = 0

/obj/item/clothing/under/geruni/verb/roll_sleeves()
	set category = null
	set src in usr
	if (rolled)
		item_state = "geruni"
		worn_state = "geruni"
		item_state_slots["slot_w_uniform"] = "geruni"
		usr << "<span class = 'danger'>You roll down your uniform's sleeves.</span>"
		rolled = 0
	else if (!rolled)
		item_state = "gerunirolledup"
		worn_state = "gerunirolledup"
		item_state_slots["slot_w_uniform"] = "gerunirolledup"
		usr << "<span class = 'danger'>You roll up your uniform's sleeves.</span>"
		rolled = 1
	update_clothing_icon()

/obj/item/clothing/under/geruni/falluni
	name = "Fallschirmjager uniform"
	desc = "Standart german uniform for fallschirmjagers. This is quite comfy and sturdy uniform."
	icon_state = "falluni"
	item_state = "falluni"
	worn_state = "falluni"

/obj/item/clothing/suit/fallsparka
	name = "Fallschirmjager Parka"
	desc = "A warm and comfy parka for fallschirmjagers."
	icon_state = "fallsparka"
	item_state = "fallsparka"
	worn_state = "fallsparka"

/obj/item/clothing/suit/sssmock
	name = "S.S. Smock"
	desc = "A camo S.S. overcoat."
	icon_state = "sssmock"
	item_state = "sssmock"
	worn_state = "sssmock"

/obj/item/clothing/under/geruni/ssuni
	name = "SS uniform"
	desc = "Camo uniform for ShutzStaffel soldiers. Sturdy, comfy, and makes you less visible in autumn. They gave you this too early by the way."
	icon_state = "newssuni"
	item_state = "newssuni"
	worn_state = "newssuni"

/obj/item/clothing/under/geruni/ssformalofc
	name = "SS Officer's Formal Uniform"
	desc = "Jet black formal uniform. Swastika armband included."
	icon_state = "ss_formal_ofc"
	item_state = "ss_formal_ofc"
	worn_state = "ss_formal_ofc"

/obj/item/clothing/head/helmet/tactical/gerhelm
	name = "German helmet"
	icon_state = "gerhelm"
	item_state = "gerhelm"

/obj/item/clothing/head/helmet/tactical/gerhelm/sshelm
	name = "SS camo helmet"
	icon_state = "sshelm"
	item_state = "sshelm"

/obj/item/clothing/head/helmet/tactical/sovhelm
	name = "Soviet helmet"
	icon_state = "sovhelm"
	item_state = "sovhelm"


//WIP, need icons - Kachnov
/obj/item/clothing/suit/armor/flammenwerfer
	name = "fireproof flammenwerfer vest"
	icon_state = "cn42"
	armor = list(melee = 30, bullet = 60, laser = 10, energy = 10, bomb = 15, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/bulletproof/cn42
	name = "CN-42 bulletproof vest"
	desc = "A heavy vest used by soviet shock troops"
	icon_state = "cn42"
	armor = list(melee = 30, bullet = 60, laser = 10, energy = 10, bomb = 15, bio = 0, rad = 0)

/obj/item/weapon/storage/belt/german
	name = "German belt pouch"
	desc = "Can hold gear like pistol, ammo and other thingies."
	icon_state = "gerbelt"
	item_state = "gerbelt"
	storage_slots = 6
	max_w_class = 3
	max_storage_space = 28
	can_hold = list(
		/obj/item/ammo_magazine/a792x33/stgmag,
		/obj/item/ammo_magazine/kar98k,
		/obj/item/ammo_magazine/mp40,
		/obj/item/weapon/material/knife,
		/obj/item/weapon/gauze_pack/gauze,
		/obj/item/weapon/grenade/explosive/stgnade,
		/obj/item/weapon/gun/projectile/pistol/luger,
		/obj/item/ammo_magazine/luger
		)

/obj/item/weapon/storage/belt/german/fallofficer
	name = "German belt"
	desc = "Can hold gear like pistol, ammo and other thingies."
	icon_state = "gerbelt"
	item_state = "gerbelt"
	storage_slots = 6
	max_w_class = 3
	max_storage_space = 20

/obj/item/weapon/storage/belt/german/fallofficer/New()
	..()
	new /obj/item/ammo_magazine/mp40(src)
	new /obj/item/ammo_magazine/mp40(src)
	new /obj/item/ammo_magazine/mp40(src)
	new /obj/item/weapon/gauze_pack/gauze(src)
	new /obj/item/weapon/grenade/explosive/stgnade(src)
	new /obj/item/weapon/grenade/explosive/stgnade(src)

/obj/item/weapon/storage/belt/german/fallsoldier
	name = "German belt"
	desc = "Can hold gear like pistol, ammo and other thingies."
	icon_state = "gerbelt"
	item_state = "gerbelt"
	storage_slots = 6
	max_w_class = 3
	max_storage_space = 20

/obj/item/weapon/storage/belt/german/fallsoldier/New()
	..()
	new /obj/item/ammo_magazine/kar98k(src)
	new /obj/item/ammo_magazine/kar98k(src)
	new /obj/item/ammo_magazine/kar98k(src)
	new /obj/item/ammo_magazine/kar98k(src)
	new /obj/item/weapon/gauze_pack/gauze(src)
	new /obj/item/weapon/grenade/explosive/stgnade(src)

/obj/item/clothing/under/doctor
	desc = "A classy suit for doctors of the 40's."
	name = "doctor's uniform"
	icon_state = "ba_suit"
	item_state = "ba_suit"

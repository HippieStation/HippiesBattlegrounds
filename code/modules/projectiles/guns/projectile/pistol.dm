/obj/item/weapon/gun/projectile/colt
	name = "vintage .45 pistol"
	desc = "A cheap Martian knock-off of a Colt M1911. Uses .45 rounds."
	magazine_type = /obj/item/ammo_magazine/c45m
	icon_state = "colt"
	caliber = ".45"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	fire_sound = 'sound/weapons/guns/fire/pistol_fire.ogg'
	load_method = MAGAZINE

/obj/item/weapon/gun/projectile/colt/detective
	magazine_type = /obj/item/ammo_magazine/c45m/flash

/obj/item/weapon/gun/projectile/colt/detective/verb/rename_gun()
	set name = "Name Gun"
	set category = "Object"
	set desc = "Rename your gun. If you're the detective."

	var/mob/M = usr
	if(!M.mind)	return 0
	if(!M.mind.assigned_role == "Detective")
		M << "<span class='notice'>You don't feel cool enough to name this gun, chump.</span>"
		return 0

	var/input = sanitizeSafe(input("What do you want to name the gun?", ,""), MAX_NAME_LEN)

	if(src && input && !M.stat && in_range(M,src))
		name = input
		M << "You name the gun [input]. Say hello to your new friend."
		return 1

/obj/item/weapon/gun/projectile/sec
	name = ".45 pistol"
	desc = "The NT Mk58 is a cheap, ubiquitous sidearm, produced by a NanoTrasen subsidiary. Found pretty much everywhere humans are. Uses .45 rounds."
	icon_state = "secguncomp"
	magazine_type = /obj/item/ammo_magazine/c45m/flash
	caliber = ".45"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	fire_sound = 'sound/weapons/guns/fire/pistol_fire.ogg'
	load_method = MAGAZINE

/obj/item/weapon/gun/projectile/sec/flash
	name = ".45 signal pistol"

/obj/item/weapon/gun/projectile/sec/wood
	desc = "The NT Mk58 is a cheap, ubiquitous sidearm, produced by a NanoTrasen subsidiary. This one has a sweet wooden grip. Uses .45 rounds."
	name = "custom .45 Pistol"
	icon_state = "secgundark"

/obj/item/weapon/gun/projectile/silenced
	name = "silenced pistol"
	desc = "A small, quiet,  easily concealable gun. Uses .45 rounds."
	icon_state = "silenced_pistol"
	w_class = 3
	caliber = ".45"
	silenced = 1
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ILLEGAL = 8)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/c45m

/obj/item/weapon/gun/projectile/deagle
	name = "desert eagle"
	desc = "A robust handgun that uses .50 AE ammo"
	icon_state = "deagle"
	item_state = "deagle"
	force = WEAPON_FORCE_PAINFULL
	caliber = ".50"
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/a50
	auto_eject = 1
	fire_sound = 'sound/weapons/guns/fire/hpistol_fire.ogg'
	unload_sound 	= 'sound/weapons/guns/interact/hpistol_magout.ogg'
	reload_sound 	= 'sound/weapons/guns/interact/hpistol_magin.ogg'
	cocked_sound 	= 'sound/weapons/guns/interact/hpistol_cock.ogg'

/obj/item/weapon/gun/projectile/deagle/gold
	desc = "A gold plated gun folded over a million times by superior martian gunsmiths. Uses .50 AE ammo."
	icon_state = "deagleg"
	item_state = "deagleg"

/obj/item/weapon/gun/projectile/deagle/camo
	desc = "A Deagle brand Deagle for operators operating operationally. Uses .50 AE ammo."
	icon_state = "deaglecamo"
	item_state = "deagleg"
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'



/obj/item/weapon/gun/projectile/gyropistol
	name = "gyrojet pistol"
	desc = "A bulky pistol designed to fire self propelled rounds"
	icon_state = "gyropistol"
	max_shells = 8
	caliber = "75"
	fire_sound = 'sound/weapons/guns/fire/hpistol_fire.ogg'
	origin_tech = list(TECH_COMBAT = 3)
	ammo_type = "/obj/item/ammo_casing/a75"
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/a75
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'
	unload_sound 	= 'sound/weapons/guns/interact/hpistol_magout.ogg'
	reload_sound 	= 'sound/weapons/guns/interact/hpistol_magin.ogg'
	cocked_sound 	= 'sound/weapons/guns/interact/hpistol_cock.ogg'

/obj/item/weapon/gun/projectile/gyropistol/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "gyropistolloaded"
	else
		icon_state = "gyropistol"

/obj/item/weapon/gun/projectile/pistol
	name = "holdout pistol"
	desc = "The Lumoco Arms P3 Whisper. A small, easily concealable gun. Uses 9mm rounds."
	icon_state = "luger"
	item_state = null
	w_class = 2
	caliber = "9mm"
	silenced = 0
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ILLEGAL = 2)
	fire_sound = 'sound/weapons/guns/fire/pistol_fire.ogg'
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/mc9mm

/obj/item/weapon/gun/projectile/pistol/flash
	name = "holdout signal pistol"
	magazine_type = /obj/item/ammo_magazine/mc9mm/flash

/obj/item/weapon/gun/projectile/pistol/attack_hand(mob/user as mob)
	if(user.get_inactive_hand() == src)
		if(silenced)
			if(user.l_hand != src && user.r_hand != src)
				..()
				return
			user << "<span class='notice'>You unscrew [silenced] from [src].</span>"
			user.put_in_hands(silenced)
			silenced = 0
			w_class = 2
			update_icon()
			return
	..()

/obj/item/weapon/gun/projectile/pistol/attackby(obj/item/I as obj, mob/user as mob)
	if (..()) // handle attachments
		return 1

	if(istype(I, /obj/item/weapon/silencer))
		if(user.l_hand != src && user.r_hand != src)	//if we're not in his hands
			user << "<span class='notice'>You'll need [src] in your hands to do that.</span>"
			return
		user.drop_item()
		user << "<span class='notice'>You screw [I] onto [src].</span>"
		silenced = I	//dodgy?
		w_class = 3
		I.loc = src		//put the silencer into the gun
		update_icon()
		return
	..()

/obj/item/weapon/gun/projectile/pistol/update_icon()
	..()
	if(silenced)
		icon_state = "[initial(icon_state)]-silencer"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/weapon/silencer
	name = "silencer"
	desc = "a silencer"
	icon = 'icons/obj/gun.dmi'
	icon_state = "silencer"
	w_class = 2

/obj/item/weapon/gun/projectile/pirate
	name = "zip gun"
	desc = "Little more than a barrel, handle, and firing mechanism, cheap makeshift firearms like this one are not uncommon in frontier systems."
	icon_state = "sawnshotgun"
	item_state = "sawnshotgun"
	handle_casings = CYCLE_CASINGS //player has to take the old casing out manually before reloading
	load_method = SINGLE_CASING
	fire_sound = 'sound/weapons/guns/fire/pistol_fire.ogg'
	max_shells = 1 //literally just a barrel

	var/global/list/ammo_types = list(
		/obj/item/ammo_casing/a357,
		/obj/item/ammo_casing/c9mmf,
		/obj/item/ammo_casing/c45f,
		/obj/item/ammo_casing/a10mm,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_casing/shotgun/pellet,
		/obj/item/ammo_casing/shotgun/pellet,
		/obj/item/ammo_casing/shotgun/pellet,
		/obj/item/ammo_casing/shotgun/beanbag,
		/obj/item/ammo_casing/shotgun/stunshell,
		/obj/item/ammo_casing/shotgun/flash,
		/obj/item/ammo_casing/a762,
		/obj/item/ammo_casing/a556
		)

/obj/item/weapon/gun/projectile/pirate/New()
	ammo_type = pick(ammo_types)

	var/obj/item/ammo_casing/ammo = ammo_type
	caliber = initial(ammo.caliber)
	desc += " Uses [caliber] rounds."
	..()

/* Ironhammer stuff */

/obj/item/weapon/gun/projectile/lamia
	name = "FS HG .44 \"Lamia\""
	desc = "FS HG .44 \"Lamia\". Uses .44 rounds."
	icon_state = "Headdeagle"
	item_state = "revolver"
	fire_sound = 'sound/weapons/guns/fire/hpistol_fire.ogg'
	caliber = ".44"
	ammo_mag = "mag_cl44"
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 4)
	load_method = MAGAZINE
	unload_sound 	= 'sound/weapons/guns/interact/hpistol_magout.ogg'
	reload_sound 	= 'sound/weapons/guns/interact/hpistol_magin.ogg'
	cocked_sound 	= 'sound/weapons/guns/interact/hpistol_cock.ogg'

/obj/item/weapon/gun/projectile/lamia/update_icon()
	overlays.Cut()
	if(!ammo_magazine)
		return
	var/ratio = ammo_magazine.stored_ammo.len * 100 / ammo_magazine.max_ammo
	ratio = round(ratio, 33)
	overlays += "deagle_[ratio]"

/obj/item/weapon/gun/projectile/giskard
	name = "FS HG .32 \"Giskard\""
	desc = "That's the 'Frozen Star' popular traumatic pistol. Can even fit into the pocket! Uses .32 rounds."
	icon_state = "giskardcivil"
	fire_sound = 'sound/weapons/guns/fire/pistol_fire.ogg'
	caliber = ".32"
	ammo_mag = "mag_cl32"
	w_class = 2
	fire_delay = 0.6
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 3)
	load_method = MAGAZINE
	accuracy = 1

/obj/item/weapon/gun/projectile/giskard/update_icon()
	..()
	if(ammo_magazine && ammo_magazine.stored_ammo.len)
		icon_state = "giskardcivil"
	else
		icon_state = "giskardcivil_empty"

/obj/item/weapon/gun/projectile/olivaw
	name = "FS HG .32 \"Olivaw\""
	desc = "That's the 'Frozen Star' popular traumatic pistol. This one seems to have a two-round burst-fire mode. Uses .32 rounds."
	icon_state = "olivawcivil"
	fire_sound = 'sound/weapons/guns/fire/pistol_fire.ogg'
	caliber = ".32"
	ammo_mag = "mag_cl32"
	fire_delay = 1.2
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3)
	load_method = MAGAZINE
	accuracy = 2

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=1.2,    move_delay=null, burst_accuracy=null, dispersion=null),
		list(mode_name="2-round bursts", burst=2, fire_delay=0.2, move_delay=4,    burst_accuracy=list(0,-1),       dispersion=list(1.2, 1.8)),
		)

/obj/item/weapon/gun/projectile/olivaw/update_icon()
	..()
	if(ammo_magazine && ammo_magazine.stored_ammo.len)
		icon_state = "olivawcivil"
	else
		icon_state = "olivawcivil_empty"


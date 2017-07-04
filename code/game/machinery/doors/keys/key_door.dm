/mob/var/hitting_key_door = 0

/obj/structure/simple_door/key_door
	var/datum/keyslot/keyslot = null
	var/keyslot_type = null
	var/health = 100
	var/initial_health = 100
	var/showed_damage_messages[4]
	var/unique_door_name = null
	material = "iron"

/obj/structure/simple_door/key_door/New()

	var/map_door_name = name

	..(material)

	if (keyslot_type)
		keyslot = new keyslot_type
	else
		keyslot = new()

	health = rand(200,300)
	initial_health = health

	spawn (2)
		if (unique_door_name && map_door_name == "door")
			name = unique_door_name
		else if (map_door_name != "door")
			name = map_door_name



/obj/structure/simple_door/key_door/attackby(obj/item/W as obj, mob/user as mob)

	var/keyslot_original_locked = keyslot.locked

	if (istype(W, /obj/item/weapon/key))
		if (istype(src, /obj/structure/simple_door/key_door/anyone))
			return
		if (keyslot.check_user(user, 1)) // even if this isn't the right key, they made an effort
			keyslot.locked = !keyslot.locked
	else if (istype(W, /obj/item/weapon/storage/belt/keychain))
		if (istype(src, /obj/structure/simple_door/key_door/anyone))
			return
		if (keyslot.check_user(user, 1))
			keyslot.locked = !keyslot.locked
	else
		if (W.force > WEAPON_FORCE_WEAK || user.a_intent == I_HURT)
			if (!user.hitting_key_door)
				user.hitting_key_door = 1
				visible_message("<span class = 'danger'>[user] hits the door with [W]!</span>")
				playsound(get_turf(src), 'sound/effects/grillehit.ogg', 100)
				health -= W.force
				damage_display()
				if (health <= 0)
					visible_message("<span class = 'danger'>[src] collapses into a pile of scrap metal!</span>")
					qdel(src)
				spawn (7)
					user.hitting_key_door = 0
				return

	var/keyslot_locked = keyslot.locked

	if (keyslot_original_locked != keyslot_locked)
		if (keyslot_locked)
			visible_message("<span class = 'warning'>[user] locks the door.</span>")
		else
			visible_message("<span class = 'notice'>[user] unlocks the door.</span>")

/obj/structure/simple_door/key_door/attack_hand(mob/user as mob)

	if (!keyslot.locked || istype(src, /obj/structure/simple_door/key_door/anyone))
		return ..(user)
	else
		user.visible_message("<span class = 'danger'>[user] knocks at the door.</span>")

/obj/structure/simple_door/key_door/Bumped(atom/user)

	if (!keyslot.locked || istype(src, /obj/structure/simple_door/key_door/anyone))
		return ..(user)
	else
		return 0


/obj/structure/simple_door/key_door/proc/damage_display()

	if (health < 20 && !showed_damage_messages[1])
		showed_damage_messages[1] = 1
		visible_message("<span class = 'danger'>[src] looks like it's about to break!</span>")
	else if (health < (initial_health/4) && !showed_damage_messages[2])
		showed_damage_messages[2] = 1
		visible_message("<span class = 'danger'>[src] looks extremely damaged!</span>")
	else if (health < (initial_health/2) && !showed_damage_messages[3])
		showed_damage_messages[3] = 1
		visible_message("<span class = 'danger'>[src] looks very damaged.</span>")
	else if (health < (initial_health/1.2) && !showed_damage_messages[4])
		showed_damage_messages[4] = 1
		visible_message("<span class = 'danger'>[src] starts to show signs of damage.</span>")
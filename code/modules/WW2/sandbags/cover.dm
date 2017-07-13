// how much do we cover mobs behind incomplete sandbags?
#define SANDBAG_BLOCK_ITEMS_CHANCE 70

/obj/structure/window/sandbag/incomplete/check_cover(obj/item/projectile/P, turf/from)

	var/effectiveness_coeff = (progress + 1)/maxProgress
	var/turf/cover = get_turf(src)
	if(!cover)
		return 1
	if (get_dist(P.starting, loc) <= 1) //Tables won't help you if people are THIS close
		return 1

	var/base_chance = SANDBAG_BLOCK_ITEMS_CHANCE - (P.penetrating * 3)
	var/extra_chance = 0

	if (ismob(P.original)) // what the firer clicked
		var/mob/m = P.original
		if (m.lying)
			extra_chance += 30
		if (ishuman(m))
			var/mob/living/carbon/human/H = m
			if (H.crouching && !H.lying)
				extra_chance += 20

	var/chance = base_chance + extra_chance

	if(prob(chance * effectiveness_coeff))
		return 1
	else
		return 0


// how much do we cover mobs behind full sandbags?
/obj/structure/window/sandbag/proc/check_cover(obj/item/projectile/P, turf/from)
	var/turf/cover = get_turf(src)
	if(!cover)
		return 1
	if (get_dist(P.starting, loc) <= 1) //Tables won't help you if people are THIS close
		return 1

	var/base_chance = SANDBAG_BLOCK_ITEMS_CHANCE - (P.penetrating * 3)
	var/extra_chance = 0

	if (ismob(P.original)) // what the firer clicked
		var/mob/m = P.original
		if (m.lying)
			extra_chance += 30
		if (ishuman(m))
			var/mob/living/carbon/human/H = m
			if (H.crouching && !H.lying)
				extra_chance += 20

	var/chance = base_chance + extra_chance

	if(prob(chance))
		return 1
	else
		return 0

// what is our chance of deflecting bullets regardless?
/proc/bullet_deflection_chance(obj/item/projectile/proj)
	var/base = 95
	if (!istype(proj))
		return base
	else
		var/subtract = max(max(proj.accuracy, 0.5) * 7, 5)
		return (base - subtract)

// procedure for both incomplete and complete sandbags
/obj/structure/window/sandbag/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)

	if (istype(mover, /obj/effect/effect/smoke))
		return TRUE

	if (!istype(mover, /obj/item))
		if(get_dir(loc, target) & dir)
			return FALSE
		else
			return TRUE
	else
		if (istype(mover, /obj/item/projectile))
			var/obj/item/projectile/proj = mover
			proj.throw_source = proj.starting
			if (proj.firer && (get_step(proj.firer, proj.firer.dir) == get_turf(src) || proj.firer.loc == get_turf(src)))
				return TRUE

		if (!mover.throw_source)
			if(get_dir(loc, target) & dir)
				return FALSE
			else
				return TRUE
		else
			switch (get_dir(mover.throw_source, get_turf(src)))
				if (NORTH, NORTHEAST)
					if (dir == EAST || dir == WEST || dir == NORTH)
						return TRUE
				if (SOUTH, SOUTHEAST)
					if (dir == EAST || dir == WEST || dir == SOUTH)
						return TRUE
				if (EAST)
					if (dir != WEST)
						return TRUE
				if (WEST)
					if (dir != EAST)
						return TRUE

			if (check_cover(mover, mover.throw_source) && prob(bullet_deflection_chance(mover)))
				visible_message("<span class = 'warning'>[mover] hits the sandbag!</span>")
				return FALSE
			else
				return TRUE

/obj/structure/window/sandbag/CheckExit(atom/movable/O as mob|obj, target as turf)

	if(get_dir(O.loc, target) == dir)
		if(istype(O, /obj/item/projectile))
			var/obj/item/projectile/P = O
			if(get_turf(src) == P.starting)
				return TRUE
			else
				if (prob(bullet_deflection_chance(P)))
					visible_message("<span class = 'warning'>[P] hits the sandbag!</span>")
					return FALSE
				else
					return TRUE
		else
			if (!O.throw_source)
				return FALSE
	return TRUE
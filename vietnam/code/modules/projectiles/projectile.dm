/obj/item/projectile
	speed = 0.4
	stutter = 2
	eyeblur = 2
	var/penetration = 1//like forcedodge but not infinite and will affect damage dealt to objects (soon)
	var/penetration_damage_falloff = 5

/obj/item/projectile/Collide(atom/A)
	if(check_ricochet(A) && check_ricochet_flag(A) && ricochets < ricochets_max)
		ricochets++
		if(A.handle_ricochet(src))
			ignore_source_check = TRUE
			return FALSE
	if(firer && !ignore_source_check)
		if(A == firer || (A == firer.loc && ismecha(A))) //cannot shoot yourself or your mech
			loc = A.loc
			return FALSE

	var/distance = get_dist(get_turf(A), starting) // Get the distance between the turf shot from and the mob we hit and use that for the calculations.
	def_zone = ran_zone(def_zone, max(100-(7*distance), 5)) //Lower accurancy/longer range tradeoff. 7 is a balanced number to use.

	if(isturf(A) && hitsound_wall)
		var/volume = Clamp(vol_by_damage() + 20, 0, 100)
		if(suppressed)
			volume = 5
		playsound(loc, hitsound_wall, volume, 1, -1)

	var/turf/target_turf = get_turf(A)

	if(!prehit(A))
		if(forcedodge || penetration)
			loc = target_turf
		return FALSE

	var/permutation = A.bullet_act(src, def_zone) // searches for return value, could be deleted after run so check A isn't null
	if(permutation == -1 || forcedodge || penetration)// the bullet passes through a dense object!
		loc = target_turf
		penetration--

		if(initial(penetration))
			damage = max(damage - penetration_damage_falloff, 0)

		if(A)
			permutated.Add(A)
		return FALSE
	else
		var/atom/alt = select_target(A)
		if(alt)
			if(!prehit(alt))
				return FALSE
			alt.bullet_act(src, def_zone)
	qdel(src)
	return TRUE
/obj/effect/effect/smoke/chem/payload
	last_duration = 200
	random_destination = 1

	New(var/newloc, var/_spread = 10, var/_destination = null)
		..(spread = _spread, dest_turf = _destination)

		for (var/datum/reagent/r in reagents.reagent_list)
			src.color = r.color
			src.alpha = r.alpha

/obj/effect/effect/smoke/chem/payload/chlorine_gas
	reagent_id = "chlorine_gas"

/obj/effect/effect/smoke/chem/payload/mustard_gas
	reagent_id = "mustard_gas"

/obj/effect/effect/smoke/chem/payload/white_phosphorus_gas
	reagent_id = "white_phosphorus_gas"

/obj/effect/effect/smoke/chem/payload/xylyl_bromide
	reagent_id = "xylyl_bromide"

/obj/effect/effect/smoke/chem/payload/zyklon_b
	reagent_id = "zyklon_b"

// special behavior designed for gas chambers
/obj/effect/effect/smoke/chem/payload/zyklon_b/Move()
	. = ..()
	if(.)
		for(var/atom/movable/AM in get_turf(src))
			if(!istype(AM, /obj/effect/effect/smoke/chem))
				reagents.splash(AM, splash_amount, copy = 1)
		if(loc == destination)
			bound_width = 96
			bound_height = 96
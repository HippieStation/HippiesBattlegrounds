/datum/train_controller
	var/faction = null
	var/list/train_car_centers = list()
	var/list/reverse_train_car_centers = list()
	var/list/train_connectors = list()
	var/list/train_railings = list()
	var/list/reverse_train_connectors = list()
	var/list/reverse_train_railings = list()
	var/officer_cars = 1
	var/storage_cars = 1
	var/soldier_cars = 1
	var/conductor_cars = 1
	var/total_cars = 0
	var/total_height = 0
	var/obj/effect/landmark/train/german_train_start/starting_point = null
	var/obj/effect/landmark/train/german_train_limit/limit_point = null
	var/direction = "FORWARDS" // right now, trains only move north to south (forwards) and south to north (backwards)
	// They don't reverse yet, because that's fucking annoying to do.
	var/moving = 0 // are we moving?
	var/halting = 0 // did the conductor stop us?
//	var/finishing_halting = 0 // did we halt recently? don't play movement sounds
	var/velocity = 3.0 // normally 2.0
	var/started_moving = 0  // calls train_start hook when set to 1 for the first time
	var/list/last_played[2] // movement, halting sounds
	var/playing = "" // ditto
	var/obj/train_car_center/last_car = null // the car closest to the front of the train
	var/obj/train_car_center/first_car = null // the car closest to the back of the train
	var/inc[2] // FORWARDS = -1, BACKWARDS = +1
	var/my_tcc_type = null

	var/halting_sound_delay = 100
	var/movement_sound_delay = 50

/datum/train_controller/proc/get_lever()
	for (var/obj/train_lever/lever in world)
		if (lever.loc && lever.faction == src.faction && lever.real)
			return lever
	return null

/datum/train_controller/german/get_lever()
	for (var/obj/train_lever/lever in world)
		if (lever.loc && istype(lever, /obj/train_lever/german) && lever.real)
			return lever
	return null

/datum/train_controller/russian/get_lever()
	for (var/obj/train_lever/lever in world)
		if (lever.loc && istype(lever, /obj/train_lever/russian) && lever.real)
			return lever
	return null
/*
/datum/train_controller/proc/get_next_mob_move(var/mob/m, var/dir)

	switch (dir)
		if (NORTH)
			return list("x" = 0, "y" = 1)
		if (SOUTH)
			return list("x" = 0, "y" = -1)
		if (EAST)
			return list("x" = 1, "y" = 0)
		if (WEST)
			return list("x" = -1, "y" = 0)*/
/*
	var/dir2x[0]
	var/dir2y[0]

	// use dir2text because maps don't support numerical keys

	dir2x[dir2text(EAST)] = 1
	dir2x[dir2text(WEST)] = -1
	dir2x[dir2text(NORTH)] = 0
	dir2x[dir2text(SOUTH)] = 0

	dir2y[dir2text(EAST)] = 0
	dir2y[dir2text(WEST)] = 0
	dir2y[dir2text(NORTH)] = 1
	dir2y[dir2text(SOUTH)] = -1

	if (moving)
		switch (direction)
			if ("FORWARDS")
				return locate(m.x+dir2x[dir2text(dir)], m.y-1+dir2y[dir2text(dir)], m.z)
			if ("BACKWARDS")
				return locate(m.x+dir2x[dir2text(dir)], m.y+1+dir2y[dir2text(dir)], m.z)
	else
		return null
*/
/datum/train_controller/New(_faction)
	faction = _faction

	inc["FORWARDS"] = -1
	inc["BACKWARDS"] = 1

	last_played["movement"] = -1
	last_played["halting"] = -1

	switch (faction)
		if ("GERMAN")
			my_tcc_type = /obj/train_car_center/german
			officer_cars = config.german_train_cars_officer
			storage_cars = config.german_train_cars_storage
			soldier_cars = config.german_train_cars_soldier
			conductor_cars = config.german_train_cars_conductor
			total_cars = officer_cars + storage_cars + soldier_cars + conductor_cars

			starting_point = locate(/obj/effect/landmark/train/german_train_start) in world
			limit_point = locate(/obj/effect/landmark/train/german_train_limit) in world

			if (!starting_point || !limit_point || !istype(starting_point) || !istype(limit_point))
				return // nope

			var/starting_y = starting_point.y
			var/starting_x = starting_point.x
			var/starting_z = starting_point.z

			var/off_di = getAreaDimensions(src, "officer")
			var/st_di = getAreaDimensions(src, "storage")
			var/so_di = getAreaDimensions(src, "soldier")
			var/con_di = getAreaDimensions(src, "conductor")

		//	var/cars_width = (off_di["width"] + st_di["width"] + so_di["width"] + con_di["width"])
			var/cars_height = (off_di["height"] + st_di["height"] + so_di["height"] + con_di["height"])

			var/num_spaces = total_cars - 1 // 2 cars = 1 space, etc
			var/extra_height = SPACES_BETWEEN_CARS * num_spaces

			total_height = cars_height + extra_height

			var/max_dist = abs(starting_point.y - limit_point.y) + 1

			if (total_height > max_dist)
				return // we fucked up. This is a huge train, or there isn't much space between the starting and limit
						// points.

			//	otherwise, continue

			var/y_inc = 0
			var/found_first_car = 0

			for (var/v in 1 to officer_cars)
				var/obj/train_car_center/tcc = new/obj/train_car_center/german/officer(locate(starting_x, starting_y + y_inc, starting_z), src)
				y_inc -= off_di["height"]
				y_inc -= SPACES_BETWEEN_CARS
				train_car_centers += tcc

				if (!found_first_car)
					first_car = tcc
					found_first_car = 1

			for (var/v in 1 to soldier_cars)
				var/obj/train_car_center/tcc = new/obj/train_car_center/german/soldier(locate(starting_x, starting_y + y_inc, starting_z), src)
				y_inc -= so_di["height"]
				y_inc -= SPACES_BETWEEN_CARS
				train_car_centers += tcc

				if (!found_first_car)
					first_car = tcc
					found_first_car = 1

			for (var/v in 1 to storage_cars) // this makes unboarding way easier
				var/obj/train_car_center/tcc = new/obj/train_car_center/german/storage(locate(starting_x, starting_y + y_inc, starting_z), src)
				y_inc -= st_di["height"]
				y_inc -= SPACES_BETWEEN_CARS
				train_car_centers += tcc

				if (!found_first_car)
					first_car = tcc
					found_first_car = 1

			for (var/v in 1 to conductor_cars)
				var/obj/train_car_center/tcc = new/obj/train_car_center/german/conductor(locate(starting_x, starting_y + y_inc, starting_z), src)
				y_inc -= con_di["height"]
				y_inc -= SPACES_BETWEEN_CARS
				train_car_centers += tcc
				last_car = tcc

				if (!found_first_car)
					first_car = tcc
					found_first_car = 1

			generate_connectors()

			reverse_train_car_centers = reverselist(train_car_centers)


			// and we're done

		if ("RUSSIAN")
			return // not implemented lmao



/datum/train_controller/proc/start_moving(var/_direction) // when the conductor decides to move

	direction = _direction
	moving = 1

	var/obj/train_lever/lever = get_lever()

	switch (direction)
		if ("FORWARDS")
			lever.icon_state = lever.pushed_state
		if ("BACKWARDS")
			lever.icon_state = lever.pulled_state

	lever.direction = direction

/datum/train_controller/proc/stop_moving()

	moving = 0
	halting = 0

	var/obj/train_lever/lever = get_lever()
	lever.icon_state = lever.none_state
	lever.direction = "NONE"


/datum/train_controller/proc/stop_moving_slow() // when the conductor decides to stop


	velocity = 1.0
	halting = 1

	spawn (50)
		moving = 0
		halting = 0
		velocity = initial(velocity)
		var/obj/train_lever/lever = get_lever()
		lever.icon_state = lever.none_state
		lever.direction = "NONE"

/datum/train_controller/proc/started_moving()
	if (!started_moving)
		started_moving = 1
		callHook("train_move")

/datum/train_controller/proc/getMoveInc()
	return inc[direction] * 1 // ?


/datum/train_controller/proc/Process()
	if (moving)
		if (can_move_check())
			spawn (10)
				started_moving() // regardless of what triggers us to move, make it start the round.

			if (direction == "FORWARDS")
				move_connectors(0)
				for (var/obj/train_car_center/tcc in train_car_centers)
					tcc._Move(direction)
			else if (direction == "BACKWARDS")
				move_connectors(1)
				for (var/obj/train_car_center/tcc in reverse_train_car_centers)
					tcc._Move(direction)
		else
			moving = 0
			var/obj/train_lever/lever = get_lever()
			lever.icon_state = lever.none_state
			lever.direction = "NONE"

/*
/datum/train_controller/proc/double_speed_process()
	if (moving)
		if (can_move_check())
			for (var/mob/m in player_list)
				if (!isobserver(m) && m.is_on_train() && m.get_train() == src && m.client)

					var/default_yinc = 0

					switch (direction)
						if ("FORWARDS")
							default_yinc = -1
						if ("BACKWARDS")
							default_yinc = 1

					var/move_x = 0
					var/move_y = 0

					if (m.next_train_move && islist(m.next_train_move))
						move_x = m.next_train_move["x"]
						move_y = m.next_train_move["y"]

					m.next_train_move = locate(m.x+move_x, m.y+move_y+default_yinc, m.z)

					var/atom/movable/pulling = null
					var/pulling_dir_from_m = 0

					if (m.pulling && abs_dist(m.pulling, m) < 2)
						pulling = m.pulling

					if (pulling)
						var/turf/N = get_step(m, NORTH)
						var/turf/S = get_step(m, SOUTH)
						var/turf/E = get_step(m, EAST)
						var/turf/W = get_step(m, WEST)

						if (N.contents.Find(m.pulling))
							pulling_dir_from_m = NORTH

						else if (S.contents.Find(m.pulling))
							pulling_dir_from_m = SOUTH

						else if (E.contents.Find(m.pulling))
							pulling_dir_from_m = EAST

						else if (W.contents.Find(m.pulling))
							pulling_dir_from_m = WEST

					m.dir = get_dir(m.loc, m.next_train_move)

					if (m.dir == SOUTHEAST || m.dir == SOUTHWEST)
						m.dir = SOUTH
					if (m.dir == NORTHEAST || m.dir == NORTHWEST)
						m.dir = NORTH

					m.Move(m.next_train_move)

					if (pulling && pulling_dir_from_m)
						switch (pulling_dir_from_m)
							if (NORTH)
								pulling.Move(locate(m.x, m.y + 1, m.z))
							if (SOUTH)
								pulling.Move(locate(m.x, m.y - 1, m.z))
							if (EAST)
								pulling.Move(locate(m.x + 1, m.y, m.z))
							if (WEST)
								pulling.Move(locate(m.x - 1, m.y, m.z))

					m.next_train_move = null
*/
/datum/train_controller/proc/move_connectors(var/reverse = 0)

	if (!moving)
		return

	var/list/moving_objs = list()

	var/list/tcs = train_connectors
	var/list/trs = train_railings

	if (reverse)
		tcs = reverse_train_connectors
		trs = reverse_train_railings

	for (var/obj/train_connector/tc in tcs)
		if (tc.loc)
			moving_objs += tc

	for (var/obj/structure/railing/train_railing/tr in trs)
		if (tr.loc)
			moving_objs += tr

	for (var/obj/o in moving_objs)
		o:_Move()
		if (istype(o, /obj/train_connector))
			var/obj/train_connector/tc = o
			tc.move_mobs()

/datum/train_controller/proc/generate_connectors()

	unoccupy_connectors()
	unoccupy_railings()

	for (var/v in 1 to train_car_centers.len)
		if (v == train_car_centers.len)
			break
		else
			var/obj/train_car_center/current = train_car_centers[v]
			var/obj/train_car_center/next = train_car_centers[v+1]
			current.connect_to(next)

	reverse_train_connectors = reverselist(train_connectors)
	reverse_train_railings = reverselist(train_railings)

/datum/train_controller/proc/unoccupy_connectors()
	for (var/obj/train_connector/tc in train_connectors)
		tc.occupied = 0
		tc.loc = null

/datum/train_controller/proc/unoccupy_railings()
	for (var/obj/structure/railing/train_railing/tr in train_railings)
		tr.occupied = 0
		tr.loc = null


/datum/train_controller/proc/add_connector(var/turf/t)

	var/obj/train_connector/using = null

	for (var/obj/train_connector/tc in train_connectors)
		if (!tc.occupied)
			using = tc
			break

	if (!using)
		var/obj/train_connector/newc = new/obj/train_connector() // experimental location unique to this map
		using = newc
		train_connectors += newc

	using.master = src
	using.occupied = 1
	using.loc = t

/datum/train_controller/proc/add_railing(var/turf/t, var/_dir)

	var/obj/train_connector/using = null

	for (var/obj/structure/railing/train_railing/tr in train_railings)
		if (!tr.occupied)
			using = tr
			break

	if (!using)
		var/obj/structure/railing/train_railing/tr = new/obj/structure/railing/train_railing() // experimental location unique to this map
		using = tr
		train_railings += tr

	using.master = src
	using.occupied = 1
	using.loc = t
	using.dir = _dir


/datum/train_controller/proc/can_move_check()

	switch (direction)

		if ("FORWARDS")
			for (var/obj/train_car_center/tcc in train_car_centers)
				if (!last_car || last_car == tcc)
					for (var/obj/train_pseudoturf/tpt in tcc.forwards_pseudoturfs)
						if (tpt.y + getMoveInc() - 1 <= limit_point.y) // since y decreases as we go down
							return 0
		if ("BACKWARDS")
			for (var/obj/train_car_center/tcc in reverse_train_car_centers)
				if (!first_car || first_car == tcc)
					for (var/obj/train_pseudoturf/tpt in tcc.backwards_pseudoturfs)
						if (tpt.y + getMoveInc() + 1 >= starting_point.y)
							return 0
	return 1

/datum/train_controller/proc/coming_to_halt()
	if (moving && can_move_check())

		if (halting)
			return 1

		switch (direction)

			if ("FORWARDS")
				for (var/obj/train_car_center/tcc in train_car_centers)
					for (var/obj/train_pseudoturf/tpt in tcc.forwards_pseudoturfs)
						if (abs(tpt.y - limit_point.y) < 20) // since y decreases as we go down
							return 1
			if ("BACKWARDS")
				for (var/obj/train_car_center/tcc in train_car_centers)
					for (var/obj/train_pseudoturf/tpt in tcc.backwards_pseudoturfs)
						if (abs(tpt.y - starting_point.y) < 20)
							return 1
	return 0


/datum/train_controller/proc/sound_loop()

	//prioritize haltings
	if (last_played["halting"] == -1 || world.time - last_played["halting"] >= halting_sound_delay)
		if (coming_to_halt() && playing == "")
			last_played["halting"] = world.time
			play_halting_sound()
			playing = "halting"
			spawn (halting_sound_delay)
				playing = ""

	if (last_played["movement"] == -1 || world.time - last_played["movement"] >= movement_sound_delay)
		if (moving && can_move_check() && playing == "")
			last_played["movement"] = world.time
			play_movement_sound()
			playing = "movement"
			spawn (movement_sound_delay)
				playing = ""


/datum/train_controller/proc/play_movement_sound()
	play_train_sound("train_movement")

/datum/train_controller/proc/play_halting_sound()
	play_train_sound("train_halting")

/datum/train_controller/proc/play_train_sound(var/sound)
	for (var/mob/m in player_list)
		if (istype(m) && m.client)
			var/obj/train_car_center/german/tcc = locate(my_tcc_type) in range(20, m)
			if (tcc && istype(tcc))
				var/volume = 100
				if (!locate(/obj/train_connector) in get_turf(m))
					var/abs_dist_from_tcc = abs(m.x - tcc.x) + abs(m.y - tcc.y)
					volume = rand(80,90) - abs_dist_from_tcc
					m.client.playsound_personal(sound, volume)
				else
					m.client.playsound_personal(sound, volume)

/datum/train_controller/proc/check_can_move_mob(var/mob/m)
	return 1

/datum/train_controller/proc/opposing_directions_check(var/mob/m)
	if (direction == "FORWARDS" && m.dir == NORTH)
		return 1
	else if (direction == "BACKWARDS" && m.dir == SOUTH)
		return 1
	return 0
// factional train controllers

/datum/train_controller/german_train_controller

/datum/train_controller/german_train_controller/New()
	..("GERMAN")

/datum/train_controller/russian_train_controller

/datum/train_controller/russian_train_controller/New()
	..("RUSSIAN")


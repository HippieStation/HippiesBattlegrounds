/*
	Click code cleanup
	~Sayu
*/

// 1 decisecond click delay (above and beyond mob/next_move)
/mob/var/next_click = 0

/*
	Before anything else, defer these calls to a per-mobtype handler.  This allows us to
	remove istype() spaghetti code, but requires the addition of other handler procs to simplify it.

	Alternately, you could hardcode every mob's variation in a flat ClickOn() proc; however,
	that's a lot of code duplication and is hard to maintain.

	Note that this proc can be overridden, and is in the case of screen objects.
*/

/atom/Click(var/location, var/control, var/params) // This is their reaction to being clicked on (standard proc)
	if(src)
		usr.ClickOn(src, params)

/atom/DblClick(var/location, var/control, var/params)
	if(src)
		usr.DblClickOn(src, params)

/*
	Standard mob ClickOn()
	Handles exceptions: Buildmode, middle click, modified clicks, mech actions

	After that, mostly just check your state, check whether you're holding an item,
	check whether you're adjacent to the target, then pass off the click to whoever
	is recieving it.
	The most common are:
	* mob/UnarmedAttack(atom,adjacent) - used here only when adjacent, with no item in hand; in the case of humans, checks gloves
	* atom/attackby(item,user) - used only when adjacent
	* item/afterattack(atom,user,adjacent,params) - used both ranged and adjacent
	* mob/RangedAttack(atom,params) - used only ranged, only used for tk and laser eyes but could be changed
*/
/mob/proc/ClickOn(var/atom/A, var/params)

	if(world.time <= next_click) // Hard check, before anything else, to avoid crashing
		return

	next_click = world.time + 1

	if(client.buildmode)
		build_click(src, client.buildmode, params, A)
		return

	var/list/modifiers = params2list(params)
	if(modifiers["shift"] && modifiers["ctrl"])
		CtrlShiftClickOn(A)
		return 1
	if(modifiers["middle"])
		MiddleClickOn(A)
		return 1
	if(modifiers["shift"])
		ShiftClickOn(A)
		return 0
	if(modifiers["alt"]) // alt and alt-gr (rightalt)
		AltClickOn(A)
		return 1
	if(modifiers["ctrl"])
		CtrlClickOn(A)
		return 1

	if(lying && istype(A, /turf/) && !istype(A, /turf/space/))
		if(A.Adjacent(src))
			scramble(A)

	if(stat || paralysis || stunned || weakened)
		return

	face_atom(A) // change direction to face what you clicked on

	if(!canClick()) // in the year 2000...
		return

	if (istype(loc, /obj/tank))
		if (A == loc)
			var/obj/tank/tank = loc
			tank.handle_seat_exit(src)
			return

	// stop looking down a ladder
	if (istype(A, /obj/structure/multiz/ladder/ww2))
		var/mob/living/carbon/human/H = src
		if (istype(H) && H.laddervision)
			H.update_laddervision(null)
			H.visible_message("<span class = 'notice'>[H] stops looking [H.laddervision_direction()] the ladder.</span>")
			return

	if(restrained())
		setClickCooldown(10)
		RestrainedClickOn(A)
		return 1

	if(in_throw_mode)
		if(isturf(A) || isturf(A.loc))
			throw_item(A)
			return 1
		throw_mode_off()

	var/obj/item/W = get_active_hand()

	if (!W)

		if (using_object && istype(using_object, /obj/item/weapon/gun/projectile/minigun))

			var/obj/item/weapon/gun/projectile/minigun/mg = using_object
			var/datum/firemode/current_mode = mg.firemodes[mg.sel_mode]
			var/rate = current_mode.burst

			var/can_fire = 0

			switch (mg.dir)
				if (EAST)
					if (A.x > mg.x)
						can_fire = 1
					else
						can_fire = 0
				if (WEST)
					if (A.x < mg.x)
						can_fire = 1
					else
						can_fire = 0
				if (NORTH)
					if (A.y > mg.y)
						can_fire = 1
					else
						can_fire = 0
				if (SOUTH)
					if (A.y < mg.y)
						can_fire = 1
					else
						can_fire = 0

			if (!can_fire)
				goto skip



			var/turf/atom_turf = get_turf(A)
			var/list/neighbors = atom_turf.neighbors()

			for (var/v in 1 to max(rate/5, 2))
				spawn (v * 1)
					if (prob(20))
						mg.force_fire(pick(neighbors), src)
					else
						mg.force_fire(A, src)

			skip


	if(W == A) // Handle attack_self
		W.attack_self(src)
		if(hand)
			update_inv_l_hand(0)
		else
			update_inv_r_hand(0)
		return 1

	//Atoms on your person
	// A is your location but is not a turf; or is on you (backpack); or is on something on you (box in backpack); sdepth is needed here because contents depth does not equate inventory storage depth.
	var/sdepth = A.storage_depth(src)
	if((!isturf(A) && A == loc) || (sdepth != -1 && sdepth <= 1))
		// faster access to objects already on you
		if(A.loc != src)
			setMoveCooldown(10) //getting something out of a backpack

		if(W)
			var/resolved = W.resolve_attackby(A, src)
			if(!resolved && A && W)
				W.afterattack(A, src, 1, params) // 1 indicates adjacency
		else
			if(ismob(A)) // No instant mob attacking
				setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
			UnarmedAttack(A, 1)
		return 1

	if(!isturf(loc)) // This is going to stop you from telekinesing from inside a closet, but I don't shed many tears for that
		return

	//Atoms on turfs (not on your person)
	// A is a turf or is on a turf, or in something on a turf (pen in a box); but not something in something on a turf (pen in a box in a backpack)
	sdepth = A.storage_depth_turf()
	if(isturf(A) || isturf(A.loc) || (sdepth != -1 && sdepth <= 1))
		if(A.Adjacent(src) || (W && (istype(W, /obj/item/weapon/flamethrower/flammenwerfer) || istype(W, /obj/item/weapon/sandbag))) && A.rangedAdjacent(src)) // see adjacent.dm

			dir = get_dir(src, A)

			if (W && istype(W, /obj/item/weapon/flamethrower/flammenwerfer) && A.rangedAdjacent(src))
				if (src.get_active_hand() != W)
					return
				var/obj/item/weapon/flamethrower/flammenwerfer/fw = W
				if (fw.lit)
					A = get_turf(A) // make sure we flame a mob's turf, not them
				else
					if (!A.Adjacent(src)) // no punching people with werfers from a distance
						return

			else if (W && istype(W, /obj/item/weapon/sandbag) && A.rangedAdjacent(src))
				if (src.get_active_hand() != W)
					return

				if (!istype(A, /obj/structure/window/sandbag/incomplete))
					A = get_turf(A) // make sure we flame a mob's turf, not them
				else
					if (!A.Adjacent(src)) // if we're adding to a sandbag wall, let us stand anywhere in range(1)
						return

				var/needs_to_be_in_front = istype(A, /turf)

				if (needs_to_be_in_front) // but if we're making a new sandbag wall, we have to click right in front of us.
					if (A != get_step(src, src.dir))
						return


			setMoveCooldown(5)

			if(W)
				// Return 1 in attackby() to prevent afterattack() effects (when safely moving items for example)
				var/resolved = W.resolve_attackby(A,src)
				if(!resolved && A && W)
					W.afterattack(A, src, 1, params) // 1: clicking something Adjacent
			else
				if(ismob(A)) // No instant mob attacking
					setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
				UnarmedAttack(A, 1)
			return
		else // non-adjacent click
			if(W)
				W.afterattack(A, src, 0, params) // 0: not Adjacent
			else
				RangedAttack(A, params)
	return 1

/mob/proc/setClickCooldown(var/timeout)
	next_move = max(world.time + timeout, next_move)

/mob/proc/canClick()
	if(config.no_click_cooldown || next_move <= world.time)
		return 1
	return 0

// Default behavior: ignore double clicks, the second click that makes the doubleclick call already calls for a normal click
/mob/proc/DblClickOn(var/atom/A, var/params)
	return

/*
	Translates into attack_hand, etc.

	Note: proximity_flag here is used to distinguish between normal usage (flag=1),
	and usage when clicking on things telekinetically (flag=0).  This proc will
	not be called at ranged except with telekinesis.

	proximity_flag is not currently passed to attack_hand, and is instead used
	in human click code to allow glove touches only at melee range.
*/
/mob/proc/UnarmedAttack(var/atom/A, var/proximity_flag)
	return

/mob/living/UnarmedAttack(var/atom/A, var/proximity_flag)

	if(!ticker)
		src << "You cannot attack people before the game has started."
		return 0

	if(stat)
		return 0

	return 1

/*
	Ranged unarmed attack:

	This currently is just a default for all mobs, involving
	laser eyes and telekinesis.  You could easily add exceptions
	for things like ranged glove touches, spitting alien acid/neurotoxin,
	animals lunging, etc.
*/
/mob/proc/RangedAttack(var/atom/A, var/params)
	if(!mutations.len) return
	if((LASER in mutations) && a_intent == I_HURT)
		LaserEyes(A) // moved into a proc below
	else if(TK in mutations)
		switch(get_dist(src,A))
			if(1 to 5) // not adjacent may mean blocked by window
				setMoveCooldown(2)
			if(5 to 7)
				setMoveCooldown(5)
			if(8 to tk_maxrange)
				setMoveCooldown(10)
			else
				return
		A.attack_tk(src)
/*
	Restrained ClickOn

	Used when you are handcuffed and click things.
	Not currently used by anything but could easily be.
*/
/mob/proc/RestrainedClickOn(var/atom/A)
	return

/*
	Middle click
	Only used for swapping hands
*/
/mob/proc/MiddleClickOn(var/atom/A)
	swap_hand()
	return

// In case of use break glass
/*
/atom/proc/MiddleClick(var/mob/M as mob)
	return
*/

/*
	Shift click
	For most mobs, examine.
	This is overridden in ai.dm
*/
/mob/proc/ShiftClickOn(var/atom/A)
	A.ShiftClick(src)
	return
/atom/proc/ShiftClick(var/mob/user)
	if(user.client && user.client.eye == user)
		user.examinate(src)
	return

/*
	Ctrl click
	For most objects, pull
*/
/mob/proc/CtrlClickOn(var/atom/A)
	A.CtrlClick(src)
	return
/atom/proc/CtrlClick(var/mob/user)
	return

/atom/movable/CtrlClick(var/mob/user)
	if(Adjacent(user))
		user.start_pulling(src)

/*
	Alt click
	Unused except for AI
*/
/mob/proc/AltClickOn(var/atom/A)
	A.AltClick(src)
	return

/atom/proc/AltClick(var/mob/user)
	var/turf/T = get_turf(src)
	if(T && user.TurfAdjacent(T))
		if(user.listed_turf == T)
			user.listed_turf = null
		else
			user.listed_turf = T
			user.client.statpanel = "Turf"
	return 1

/mob/proc/TurfAdjacent(var/turf/T)
	return T.AdjacentQuick(src)

/*
	Control+Shift click
	Unused except for AI
*/
/mob/proc/CtrlShiftClickOn(var/atom/A)
	A.CtrlShiftClick(src)
	return

/atom/proc/CtrlShiftClick(var/mob/user)
	return

/*
	Misc helpers

	Laser Eyes: as the name implies, handles this since nothing else does currently
	face_atom: turns the mob towards what you clicked on
*/
/mob/proc/LaserEyes(atom/A)
	return

/mob/living/LaserEyes(atom/A)
	setClickCooldown(4)
	var/turf/T = get_turf(src)

	var/obj/item/projectile/beam/LE = new (T)
	LE.icon = 'icons/effects/genetics.dmi'
	LE.icon_state = "eyelasers"
	playsound(usr.loc, 'sound/weapons/taser2.ogg', 75, 1)
	LE.launch(A)
/mob/living/carbon/human/LaserEyes()
	if(nutrition>0)
		..()
		nutrition = max(nutrition - rand(1,5),0)
		handle_regular_hud_updates()
	else
		src << "<span class='warning'>You're out of energy!  You need food!</span>"

// Simple helper to face what you clicked on, in case it should be needed in more than one place
/mob/proc/face_atom(var/atom/A)
	if(!A || !x || !y || !A.x || !A.y) return
	var/dx = A.x - x
	var/dy = A.y - y
	if(!dx && !dy) return

	var/direction
	if(abs(dx) < abs(dy))
		if(dy > 0)	direction = NORTH
		else		direction = SOUTH
	else
		if(dx > 0)	direction = EAST
		else		direction = WEST
	if(direction != dir)
		facedir(direction)

/mob/proc/scramble(var/atom/A)
	var/direction
	if(stat || buckled || paralysis || stunned || sleeping || (status_flags & FAKEDEATH) || restrained() || (weakened > 5))
		return
	if(!istype(src.loc, /turf/))
		return
	if(!A || !x || !y || !A.x || !A.y) return
	if(scrambling)
		return
	if(!has_limbs)
		src << "\red You can't even move yourself - you have no limbs!"
	var/dx = A.x - x
	var/dy = A.y - y
	if(!dx && !dy) return

	if(abs(dx) < abs(dy))
		if(dy > 0)	direction = NORTH
		else		direction = SOUTH
	else
		if(dx > 0)	direction = EAST
		else		direction = WEST
	if(direction)

		var/turf/target = get_step(src, direction)
		if (target.check_prishtina_block(src))
			return 0

		scrambling = 1
		sleep(2)
		src.visible_message("\red <b>[src]</b> crawls!")
		sleep(11)
		Move(target)
		scrambling = 0
		dir = 2
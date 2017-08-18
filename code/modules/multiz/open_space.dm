var/datum/controller/process/open_space/OS_controller = null

/datum/controller/process/open_space
	var/list/open_spaces = list()

/datum/controller/process/open_space/setup()
	name = "openspace"
	schedule_interval = 1 SECONDS // every second
	start_delay = 12
	OS_controller = src

/datum/controller/process/open_space/doWork()
	for (var/turf/simulated/open/T in open_spaces)
		T.update_icon()

/turf/simulated/open/New()
	..()
	if(OS_controller)
		OS_controller.open_spaces += src

/turf/simulated/open/Del()
	if(OS_controller)
		OS_controller.open_spaces -= src
	..()

/turf/simulated/open/update_icon()
	overlays.Cut()
	var/turf/below = GetBelow(src)
	if (!isturf(below))
		below = get_turf(below)
	if(below)
		icon = below.icon
		icon_state = below.icon_state
		dir = below.dir
		color = below.color//rgb(127,127,127)
	//	overlays += below.overlays // for some reason this turns an open
	// space into plating.

		if(!istype(below,/turf/simulated/open))
			// get objects
			var/image/o_img = list()
			for(var/obj/o in below)
				// ingore objects that have any form of invisibility
				if(o.invisibility) continue
				var/image/temp2 = image(o, dir=o.dir, layer = o.layer)
				temp2.plane = plane
				temp2.color = o.color//rgb(127,127,127)
				temp2.overlays += o.overlays
				o_img += temp2
			overlays += o_img

		var/image/over_OS_darkness = image('icons/turf/floors.dmi', "black_open")
		over_OS_darkness.plane = OVER_OPENSPACE_PLANE
		over_OS_darkness.layer = MOB_LAYER
		overlays += over_OS_darkness
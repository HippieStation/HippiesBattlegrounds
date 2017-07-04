/obj/screen/plane
	name = ""
	screen_loc = "CENTER"
	blend_mode = BLEND_MULTIPLY
	layer = 1

/obj/screen/plane/New(var/client/C)
	..()
	if(istype(C)) C.screen += src
	verbs.Cut()

/obj/screen/plane/master
	appearance_flags = NO_CLIENT_COLOR | PLANE_MASTER | RESET_TRANSFORM | RESET_COLOR | RESET_ALPHA
	color = list(null,null,null,"#0000","#000f")  // Completely black.
	plane = MASTER_PLANE

/obj/screen/plane/dark
	blend_mode = BLEND_ADD
	plane = DARK_PLANE // Just below the master plane.
	icon = 'icons/planar_lighting/over_dark.dmi'
	alpha = 10
	appearance_flags = RESET_TRANSFORM | RESET_COLOR | RESET_ALPHA

/obj/screen/plane/dark/New()
	..()
	var/matrix/M = matrix()
	M.Scale(world.view*2.2)
	transform = M

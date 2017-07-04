//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/obj/item/weapon/implantcase
	name = "glass case"
	desc = "A case containing an implant."
	icon = 'icons/obj/items.dmi'
	icon_state = "implantcase-0"
	item_state = "implantcase"
	throw_speed = 1
	throw_range = 5
	w_class = 1.0
	var/obj/item/weapon/implant/implant = null
	var/implant_type = null

/obj/item/weapon/implantcase/New()
	src.implant = new implant_type(src)
	..()
	return

/obj/item/weapon/implantcase/proc/update()
	if (src.implant)
		src.icon_state = text("implantcase-[]", src.implant.implant_color)
	else
		src.icon_state = "implantcase-0"
	return

/obj/item/weapon/implantcase/attackby(obj/item/weapon/I as obj, mob/user as mob)
	..()
	if (istype(I, /obj/item/weapon/pen))
		var/t = input(user, "What would you like the label to be?", text("[]", src.name), null)  as text
		if (user.get_active_hand() != I)
			return
		if((!in_range(src, usr) && src.loc != user))
			return
		t = sanitizeSafe(t, MAX_NAME_LEN)
		if(t)
			src.name = text("Glass Case - '[]'", t)
		else
			src.name = "Glass Case"
	else if(istype(I, /obj/item/weapon/reagent_containers/syringe))
		if(!src.implant)	return
		if(!src.implant.allow_reagents)	return
		if(src.implant.reagents.total_volume >= src.implant.reagents.maximum_volume)
			user << "<span class='warning'>\The [src] is full.</span>"
		else
			spawn(5)
				I.reagents.trans_to_obj(src.implant, 5)
				user << "<span class='notice'>You inject 5 units of the solution. The syringe now contains [I.reagents.total_volume] units.</span>"
	else if (istype(I, /obj/item/weapon/implanter))
		var/obj/item/weapon/implanter/M = I
		if (M.implant)
			if ((src.implant || M.implant.implanted))
				return
			M.implant.loc = src
			src.implant = M.implant
			M.implant = null
			src.update()
			M.update()
		else
			if (src.implant)
				if (M.implant)
					return
				src.implant.loc = M
				M.implant = src.implant
				src.implant = null
				update()
			M.update()
	return

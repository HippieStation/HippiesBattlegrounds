
/obj/item/weapon/reagent_containers/food/drinks/drinkingglass
	name = "drinking glass"
	desc = "A standard drinking glass."
	icon_state = "glass-highball"
	amount_per_transfer_from_this = 5
	volume = 30
	unacidable = 1 //glass
	center_of_mass = list("x"=16, "y"=10)
	var/glass_type = "highball"
	var/salted = 0
	var/umbrella = null
	var/cocktail_food = null
	var/image/fluid_image

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/New()
	..()
	fluid_image = image('icons/obj/drinks.dmi', "fluid-[glass_type]")
	update_icon()

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/on_reagent_change()
	src.update_icon()

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/update_icon()
	src.overlays = null
	if(umbrella)
		var/umbrella_icon = icon('icons/obj/drinks.dmi', "[glass_type]-umbrella[umbrella]")
		src.overlays += image("icon" = umbrella_icon, "layer" = FLOAT_LAYER - 1)
	if(cocktail_food)
		var/cocktail_food_icon = icon('icons/obj/drinks.dmi', "[glass_type]-[cocktail_food]")
		src.overlays += image("icon" = cocktail_food_icon, "layer" = FLOAT_LAYER - 1)
	if(salted)
		var/salted_icon = icon('icons/obj/drinks.dmi', "[glass_type]-salted")
		src.overlays += image("icon" = salted_icon, "layer" = FLOAT_LAYER)
	if(src.reagents.total_volume == 0)
		return
	if(src.reagents.total_volume > 0)
		if(!fluid_image)
			fluid_image = image('icons/obj/drinks.dmi', "fluid-[glass_type]")
		fluid_image.color = reagents.get_color()
		src.overlays += src.fluid_image
	return

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/cocktail_stuff))
		if(src.umbrella || src.cocktail_food)
			user << "<span class='warning'>There's not enough room to add [W.name]!</span>"
			return
		user << "<span class='notice'>You add [W.name] to [src.name].</span>"
		if(istype(W, /obj/item/cocktail_stuff/umbrella))
			var/obj/item/cocktail_stuff/umbrella/C = W
			src.umbrella = "[C.umbrella_color]"
		else if(istype(W, /obj/item/cocktail_stuff/maraschino_cherry))
			src.cocktail_food = "cherry"
		else if(istype(W, /obj/item/cocktail_stuff/cocktail_olive))
			src.cocktail_food = "olive"
		else if(istype(W, /obj/item/cocktail_stuff/celery))
			src.cocktail_food = "celery"
		qdel(W)
		src.update_icon()
		return
	else if(istype(W, /obj/item/weapon/reagent_containers) && W.is_open_container() && W.reagents.has_reagent("sodiumchloride"))
		if (src.salted)
			user << "<span class='warning'>The rim of [src.name] is already salted!</span>"
			return
		else if(W.reagents.get_reagent_amount("sodiumchloride") >= 5)
			user << "<span class='notice'>You salt the rim of [src.name].</span>"
			W.reagents.remove_reagent("sodiumchloride", 5)
			src.salted = 1
			src.update_icon()
			return
		else
			user << "<span class='warning'>There's not enough salt in [W.name] to salt the rim!</span>"
			return
	else
		return ..()

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/attack_self(mob/user as mob)
	var/mob/living/carbon/human/H = user
	var/list/actions = list()

	if(src.umbrella)
		actions += "Remove the umbrella"
	if(src.cocktail_food)
		actions += "Remove the [src.cocktail_food]"
	if(!actions.len)
		user << "<span class='warning'>You can't think of anything to do with the glass.</span>"
		return

	var/action = input(user, "What do you want to do with [src]?") as null|anything in actions
	switch(action)
		if("Remove the umbrella")
			var/obj/item/cocktail_stuff/umbrella/U = new(H.loc)
			U.umbrella_color = src.umbrella
			src.umbrella = null
		if("Remove the cherry")
			new /obj/item/cocktail_stuff/maraschino_cherry(H.loc)
			src.cocktail_food = null
		if("Remove the olive")
			new /obj/item/cocktail_stuff/cocktail_olive(H.loc)
			src.cocktail_food = null
		if("Remove the celery")
			new /obj/item/cocktail_stuff/celery(H.loc)
			src.cocktail_food = null
	src.update_icon()
	return

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/shot
	name = "shot glass"
	icon_state = "glass-shot"
	glass_type = "shot"
	amount_per_transfer_from_this = 15
	volume = 15

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/lowball
	name = "lowball glass"
	icon_state = "glass-lowball"
	glass_type = "lowball"
	volume = 30

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/cocktail
	name = "cocktail glass"
	icon_state = "glass-cocktail"
	glass_type = "cocktail"
	volume = 20

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/wine
	name = "wine glass"
	icon_state = "glass-wine"
	glass_type = "wine"
	volume = 30

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/flute
	name = "flute glass"
	icon_state = "glass-flute"
	glass_type = "flute"
	volume = 20

// for /obj/machinery/vending/sovietsoda
/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/soda
	New()
		..()
		reagents.add_reagent("sodawater", 50)
		on_reagent_change()

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/cola
	New()
		..()
		reagents.add_reagent("cola", 50)
		on_reagent_change()

// increase or decrease the amount of items in a crate
/obj/structure/closet/crate/proc/resize(decimal)
	if (decimal > 1.0)
		var/add_crates = max(1, ceil((decimal - 1.0) * contents.len))
		for (var/v in 1 to add_crates)
			var/atom/object = pick(contents)
			if (object)
				var/object_type = object.type
				new object_type(src)

	else if (decimal < 1.0)
		var/remove_crates = ceil((1.0 - decimal) * contents.len)
		for (var/v in 1 to remove_crates)
			if (!contents.len)
				break
			contents -= pick(contents)


/obj/structure/closet/crate/wood
	name = "Wood planks crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/steel
	name = "Steel sheets crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/iron
	name = "Iron ingots crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/metal
	name = "Metal sheet crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/flammenwerfer_fueltanks
	name = "Flammenwerfer fueltanks crate"
	icon = 'icons/WW2/artillery_crate.dmi'
	icon_state = "closed"
	icon_opened = "opened"
	icon_closed = "closed"

/obj/structure/closet/crate/tank_fueltanks
	name = "Tank fueltanks crate"
	icon = 'icons/WW2/artillery_crate.dmi'
	icon_state = "closed"
	icon_opened = "opened"
	icon_closed = "closed"

/obj/structure/closet/crate/maximbelt
	name = "Maxim ammo crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/bint
	name = "Bint crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/gauze
	name = "Gauze crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/mosinammo
	name = "Mosin ammo crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/ppshammo
	name = "PPSh ammo crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/lugerammo
	name = "Luger ammo crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/c45ammo
	name = ".45 ammo crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/kar98kammo
	name = "Kar98k ammo crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/mp40kammo
	name = "Mp40 ammo crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/mg34ammo
	name = "Mg34 ammo crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/mp43ammo
	name = "Mp43 ammo crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/bettymines
	name = "Betty mines crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/dpammo
	name = "DP disk crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/grenade
	name = "Stielgranate crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/panzerfaust
	name = "Panzerfaust crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/gersnade
	name = "Smoke grenade crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/sovnade
	name = "RGD crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/sandbags
	name = "Sandbags crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/flares_ammo
	name = "Flaregun Ammo crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/flares
	name = "Flares crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/bayonets
	name = "Bayonets crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/supply_req_sheets
	name = "Supply requisition forms crate"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/rations/
	name = "Rations"
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"

/obj/structure/closet/crate/rations/New()
	..()
	update_capacity(30)
	var/textpath = "[type]"
	if (findtext(textpath, GERMAN))
		if (findtext(textpath, "solids"))
			for (var/v in 1 to rand(10,15))
				contents += new_ration(GERMAN, "solid")
		if (findtext(textpath, "liquids"))
			for (var/v in 1 to rand(10,15))
				contents += new_ration(GERMAN, "liquid")
		if (findtext(textpath, "desserts"))
			for (var/v in 1 to rand(10,15))
				contents += new_ration(GERMAN, "dessert")
		if (findtext(textpath, "meat"))
			for (var/v in 1 to rand(10,15))
				contents += new_ration(GERMAN, "meat")
	else if (findtext(textpath, "soviet"))
		if (findtext(textpath, "solids"))
			for (var/v in 1 to rand(10,15))
				contents += new_ration(RUSSIAN, "solid")
		if (findtext(textpath, "liquids"))
			for (var/v in 1 to rand(10,15))
				contents += new_ration(RUSSIAN, "liquid")
	/*	if (findtext(textpath, "desserts"))
			for (var/v in 1 to rand(10,15))
				contents += new_ration("SOVIET", "dessert")*/
		if (findtext(textpath, "meat"))
			for (var/v in 1 to rand(10,15))
				contents += new_ration(RUSSIAN, "meat")

/obj/structure/closet/crate/rations/german_solids
	name = "Rations: solids"

/obj/structure/closet/crate/rations/german_liquids
	name = "Rations: liquids"

/obj/structure/closet/crate/rations/german_desserts
	name = "Rations: dessert"

/obj/structure/closet/crate/rations/german_meat
	name = "Rations: meat"

/obj/structure/closet/crate/rations/soviet_solids
	name = "Rations: solids"

/obj/structure/closet/crate/rations/soviet_liquids
	name = "Rations: liquids"

/obj/structure/closet/crate/rations/soviet_desserts
	name = "Rations: dessert"

/obj/structure/closet/crate/rations/soviet_meat
	name = "Rations: meat"

// 5 wood planks with 25 each = 125 wood planks (25 barricades)
/obj/structure/closet/crate/wood/New()
	..()
	update_capacity(5)
	for (var/v in 1 to 5)
		var/obj/item/stack/S = new/obj/item/stack/material/wood(src)
		S.amount = 25

// 5 steel sheets with 25 each = 125 steel sheets
/obj/structure/closet/crate/steel/New()
	..()
	update_capacity(5)
	for (var/v in 1 to 5)
		var/obj/item/stack/S = new/obj/item/stack/material/steel(src)
		S.amount = 25

// 5 iron ingots with 25 each = 125 iron ingots
/obj/structure/closet/crate/iron/New()
	..()
	update_capacity(5)
	for (var/v in 1 to 5)
		var/obj/item/stack/S = new/obj/item/stack/material/iron(src)
		S.amount = 25

/obj/structure/closet/crate/flammenwerfer_fueltanks/New()
	..()
	update_capacity(20)
	for (var/v in 1 to 20)
		new/obj/item/weapon/flammenwerfer_fueltank(src)

/obj/structure/closet/crate/tank_fueltanks/New()
	..()
	update_capacity(20)
	for (var/v in 1 to 20)
		new/obj/item/weapon/tank_fueltank(src)

/obj/structure/closet/crate/maximbelt/New()
	..()
	update_capacity(4)
	for (var/v in 1 to 4)
		new /obj/item/ammo_magazine/maxim(src)

/obj/structure/closet/crate/mosinammo/New()
	..()
	update_capacity(24)
	for (var/v in 1 to 24)
		new /obj/item/ammo_magazine/mosin(src)

/obj/structure/closet/crate/kar98kammo/New()
	..()
	update_capacity(27)
	for (var/v in 1 to 27)
		new /obj/item/ammo_magazine/kar98k(src)

/obj/structure/closet/crate/mp40kammo/New()
	..()
	update_capacity(24)
	for (var/v in 1 to 24)
		new /obj/item/ammo_magazine/mp40(src)

/obj/structure/closet/crate/mp43ammo/New()
	..()
	update_capacity(21)
	for (var/v in 1 to 21)
		new /obj/item/ammo_magazine/a762/akm(src)

/obj/structure/closet/crate/mg34ammo/New()
	..()
	update_capacity(13)
	for (var/v in 1 to 13)
		new /obj/item/ammo_magazine/a762(src)

/obj/structure/closet/crate/ppshammo/New()
	..()
	update_capacity(17)
	for (var/v in 1 to 17)
		new /obj/item/ammo_magazine/a556/m4(src)


/obj/structure/closet/crate/lugerammo/New()
	..()
	update_capacity(15)
	for (var/v in 1 to 15)
		new /obj/item/ammo_magazine/luger(src)

/obj/structure/closet/crate/c45ammo/New()
	..()
	update_capacity(15)
	for (var/v in 1 to 15)
		new /obj/item/ammo_magazine/c45m(src)

/obj/structure/closet/crate/bettymines/New()
	..()
	update_capacity(20)
	for (var/v in 1 to 20)
		new /obj/item/device/mine/betty(src)

/obj/structure/closet/crate/dpammo/New()
	..()
	update_capacity(15)
	for (var/v in 1 to 15)
		new /obj/item/ammo_magazine/a762/pkm(src)

/obj/structure/closet/crate/bint/New()
	..()
	update_capacity(18)
	for (var/v in 1 to 18)
		new /obj/item/weapon/gauze_pack/bint(src)


/obj/structure/closet/crate/gauze/New()
	..()
	update_capacity(17)
	for (var/v in 1 to 17)
		new /obj/item/weapon/gauze_pack/gauze(src)

/obj/structure/closet/crate/sovnade/New()
	..()
	update_capacity(24)
	for (var/v in 10 to 24)
		new /obj/item/weapon/grenade/explosive/rgd(src)

/obj/structure/closet/crate/grenade/New()
	..()
	update_capacity(24)
	for (var/v in 1 to 24)
		new /obj/item/weapon/grenade/explosive/stgnade(src)

/obj/structure/closet/crate/panzerfaust/New()
	..()
	update_capacity(24)
	for (var/v in 1 to 24)
		new /obj/item/weapon/gun/launcher/rocket/panzerfaust(src)


/obj/structure/closet/crate/gersnade/New()
	..()
	update_capacity(10)
	for (var/v in 1 to 10)
		new /obj/item/weapon/grenade/smokebomb/gernade(src)


/obj/structure/closet/crate/sandbags/New()
	..()
	update_capacity(66)
	// more than tripled this to 100 bags, experimental. Didn't seem like Germans had enough to make a decent FOB
	// now this is 66 because 100 seemed like way too many
	for (var/v in 1 to 66) // this was 24, I made it 30, meaning you can make 5 sandbag walls per crate, as each takes 6 right now
		new /obj/item/weapon/sandbag(src)

/obj/structure/closet/crate/flares_ammo/New()
	..()

	update_capacity(10)
	for (var/v in 1 to 10)
		new /obj/item/ammo_magazine/flare/red(src)
		new /obj/item/ammo_magazine/flare/green(src)
		new /obj/item/ammo_magazine/flare/yellow(src)

/obj/structure/closet/crate/flares/New()
	..()

	update_capacity(50)
	for (var/v in 1 to 50)
		new /obj/item/device/flashlight/flare(src)

/obj/structure/closet/crate/bayonets/New()
	..()

	update_capacity(20)
	for (var/v in 1 to 20)
		new /obj/item/attachment/bayonet(src)

/obj/structure/closet/crate/supply_req_sheets/New()
	..()

	update_capacity(50)
	for (var/v in 1 to 50)
		new /obj/item/weapon/paper/supply_train_requisitions_sheet(src)

//arty

/obj/structure/closet/crate/artillery
	name = "German artillery shell crate"
	icon = 'icons/WW2/artillery_crate.dmi'
	icon_state = "closed2"
	icon_opened = "opened"
	icon_closed = "closed2"

	New()
		..()
		for (var/v in 1 to 25)
			new/obj/item/artillery_ammo(src)

/obj/structure/closet/crate/artillery_gas
	name = "German gas artillery shell crate"
	icon = 'icons/WW2/artillery_crate.dmi'
	icon_state = "closed2"
	icon_opened = "opened"
	icon_closed = "closed2"

	New()
		..()
		for (var/v in 1 to 4) // 16 total
			new/obj/item/artillery_ammo/gaseous/green_cross/chlorine(src)
			new/obj/item/artillery_ammo/gaseous/yellow_cross/mustard(src)
			new/obj/item/artillery_ammo/gaseous/yellow_cross/white_phosphorus(src)
			new/obj/item/artillery_ammo/gaseous/blue_cross/xylyl_bromide(src)

/obj/structure/closet/crate/gasmasks
	name = "Gasmask crate"
	icon = 'icons/WW2/artillery_crate.dmi'
	icon_state = "closed"
	icon_opened = "opened"
	icon_closed = "closed"

	New()
		..()
		for (var/v in 1 to 10)
			new/obj/item/clothing/mask/gas/german(src)

/obj/structure/closet/crate/artillery/russian
	name = "Russian artillery shell crate"

	New()
		..()
		for (var/v in 1 to 20)
			new/obj/item/artillery_ammo(src)

		for (var/v in 1 to 2)
			new/obj/item/artillery_ammo/gaseous/green_cross/chlorine(src)

		for (var/v in 1 to 6)
			new/obj/item/artillery_ammo/gaseous/blue_cross/xylyl_bromide(src)

		new/obj/item/artillery_ammo/gaseous/yellow_cross/mustard(src)
		new/obj/item/artillery_ammo/gaseous/yellow_cross/white_phosphorus(src)
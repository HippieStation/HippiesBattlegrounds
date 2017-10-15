/obj/item/weapon/paper/supply_train_requisitions_sheet
	name = "Supply Train Requisitions"
	desc = "Must be signed by an Officer to be valid."

	var/list/purchases = list()

	var/list/signatures = list()

	var/memo = ""

	var/list/crate_types = list(

	// AMMO AND MISC.
	"Flammenwerfer Fuel Tanks" = /obj/structure/closet/crate/flammenwerfer_fueltanks,
	"Tank Fuel Tanks" = /obj/structure/closet/crate/tank_fueltanks,
	"Maxim Belts" = /obj/structure/closet/crate/maximbelt,
	"Guaze" = /obj/structure/closet/crate/gauze,
	"Luger Ammo" = /obj/structure/closet/crate/lugerammo,
	"Kar Ammo" = /obj/structure/closet/crate/kar98kammo,
	"Mp40 Ammo" = /obj/structure/closet/crate/mp40kammo,
	"Mg34 Ammo" = /obj/structure/closet/crate/mg34ammo,
	"Mp43 Ammo" = /obj/structure/closet/crate/mp43ammo,
	"Mines Ammo" = /obj/structure/closet/crate/bettymines,
	"Grenades" = /obj/structure/closet/crate/grenade,
	"Panzerfausts" = /obj/structure/closet/crate/panzerfaust,
	"Smoke Grenades" = /obj/structure/closet/crate/gersnade, // too lazy to fix this typo rn
	"Sandbags" = /obj/structure/closet/crate/sandbags,
	"Flaregun Ammo" = /obj/structure/closet/crate/flares_ammo,
	"Flares" = /obj/structure/closet/crate/flares,
	"Bayonet" = /obj/structure/closet/crate/bayonets,
	"Solid Rations" = /obj/structure/closet/crate/rations/german_solids,
	"Liquid Rations" = /obj/structure/closet/crate/rations/german_liquids,
	"Dessert Rations" = /obj/structure/closet/crate/rations/german_desserts,
	"Supply Requisition Sheets" = /obj/structure/closet/crate/supply_req_sheets,

	// MATERIALS
	"Wood Planks" = /obj/structure/closet/crate/wood,
	"Steel Sheets" = /obj/structure/closet/crate/steel,
	"Iron Ingots" = /obj/structure/closet/crate/iron,

	// GUNS & ARTILLERY
	"Flammenwerfer" = /obj/item/weapon/storage/backpack/flammenwerfer,
	"7,5 cm FK 18 Artillery Piece" = /obj/machinery/artillery,
	"Luger Crate" = /obj/structure/closet/crate/lugers,

	// ARTILLERY AMMO
	"Artillery Ballistic Shells Crate" = /obj/structure/closet/crate/artillery,
	"Artillery Gas Shells Crate" = /obj/structure/closet/crate/artillery_gas,

	// CLOSETS
	"Tool Closet" = /obj/structure/closet/toolcloset,

	// MINES
	"Betty Mines Crate" = /obj/structure/closet/crate/bettymines

	)

	var/list/costs = list(

	// AMMO AND MISC.
	"Flammenwerfer Fuel Tanks" = 50,
	"Tank Fuel Tanks" = 75,
	"Maxim Belts" = 40,
	"Guaze" = 35,
	"Luger Ammo" = 30,
	"Kar Ammo" = 35,
	"Mp40 Ammo" = 40,
	"Mg34 Ammo" = 40,
	"Mp43 Ammo" = 40,
	"Mines Ammo" = 50,
	"Grenades" = 65,
	"Panzerfausts" = 60,
	"Smoke Grenades" = 55, // too lazy to fix this typo rn
	"Sandbags" = 20,
	"Flaregun Ammo" = 15,
	"Flares" = 10,
	"Bayonet" = 10,
	"Solid Rations" = 80,
	"Liquid Rations" = 80,
	"Dessert Rations" = 160,
	"Supply Requisition Sheets" = 10,

	// MATERIALS
	"Wood Planks" = 75,
	"Steel Sheets" = 100,
	"Iron Ingots" = 125,

	// GUNS & ARTILLERY
	"Flammenwerfer" = 250,
	"7,5 cm FK 18 Artillery Piece" = 300,
	"Luger Crate" = 400,

	// ARTILLERY AMMO
	"Artillery Ballistic Shells Crate" = 100,
	"Artillery Gas Shells Crate" = 200,

	// CLOSETS
	"Tool Closet" = 50,

	// MINES
	"Betty Mines Crate" = 200

	)

/obj/item/weapon/paper/supply_train_requisitions_sheet/New()
	..()
	regenerate_info()

/obj/item/weapon/paper/supply_train_requisitions_sheet/attack_self(mob/living/user as mob)
	user.examinate(src) // no crumpling

/obj/item/weapon/paper/supply_train_requisitions_sheet/show_content(var/mob/user, var/forceshow=0)
	regenerate_info()
	if(!(istype(user, /mob/living/carbon/human) || isghost(user) || istype(user, /mob/living/silicon)) && !forceshow)
		user << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[stars(info)]</BODY></HTML>", "window=[name]")
		onclose(user, "[name]")
	else
		user << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[info]</BODY></HTML>", "window=[name]")
		onclose(user, "[name]")

/obj/item/weapon/paper/supply_train_requisitions_sheet/attackby(obj/item/weapon/P as obj, var/mob/user as mob)
	if(istype(P, /obj/item/weapon/pen))
		if(icon_state == "scrap")
			user << "<span class='warning'>\The [src] is too crumpled to write on.</span>"
		else
			var/mob/living/carbon/human/H = user
			if (!istype(H) || !H.original_job)
				return
			var/sign = input("Sign the [src.name]?") in list("Yes", "No")
			if (sign == "Yes")
				if (do_after(H, 20, get_turf(H)))
					if (loc == H)
						visible_message("<span class = 'notice'>[H] signs [src.name].</span>")
						signatures += "<i>[H.real_name] - [H.original_job.title]</i>"
						regenerate_info()
						show_content(H)

/obj/item/weapon/paper/supply_train_requisitions_sheet/proc/regenerate_info()

	info_links = {"
	<b><big>CRATES</big></b><br><br>
	"}

	for (var/name in crate_types)
		info_links += "[make_purchase_href_link(name)]<br> - [costs[name]] requisition points<br>"

	info_links += "<br><br><b>Purchasing:</b><br><br>"

	var/total_cost = 0

	for (var/purchase in purchases)
		info_links += "<i>[purchase]</i><br>"
		total_cost += costs[purchase]

	if (purchases.len)
		info_links += "<br><b>Total Cost:<b> [total_cost]<br>"

	info_links += "[signatures()]<br><br>"

	if (memo)
		info_links += "<br>[memo]"

	info = info_links

	if (info && icon_state != "scrap")
		icon_state = "paper_words"

/obj/item/weapon/paper/supply_train_requisitions_sheet/proc/make_purchase_href_link(var/name)
	return "<A href='?src=\ref[src];purchase=[name]'>[name]</a>"

/obj/item/weapon/paper/supply_train_requisitions_sheet/proc/signatures()
	. = "<br><br><b>Signatures:</b><br>"
	if (signatures.len)
		for (var/signature in signatures)
			. += "[signature]<br>"
	else
		. += "<i>Please sign your name here.</i><br>"

/obj/item/weapon/paper/supply_train_requisitions_sheet/Topic(href, href_list)
	..()

	if(!usr || (usr.stat || usr.restrained()))
		return

	var/mob/living/carbon/human/H = usr

	if (!istype(H))
		return

	if (href_list["purchase"])
		var/purchase = href_list["purchase"]
		if (istype(H.l_hand, /obj/item/weapon/pen) || istype(H.r_hand, /obj/item/weapon/pen))
			purchases += purchase
			regenerate_info()
			show_content(H)
		else
			H << "<span class = 'warning'>You must have a pen in-hand to write down a purchase.</span>"

/obj/item/weapon/paper/supply_train_requisitions_sheet/proc/generate_memoend(var/datum/train_controller/german_supplytrain_controller/train)
	return "<br><i>As of the time this was printed, you have [train.supply_points] Supply Requisition Points remaining.</i>"

/obj/item/weapon/paper/supply_train_requisitions_sheet/proc/supplytrain_process(var/datum/train_controller/german_supplytrain_controller/train)

	if (!purchases.len)
		memo = ""
		goto end

	var/list/create_crates = list()

	memo = ""

	var/SO_sig = 0
	var/QM_sig = 0
	var/CO_sig = 0

	for (var/signature in signatures)
		if (findtext(signature, "Stabsgefreiter"))
			QM_sig = 1
		if (findtext(signature, "Stabsoffizier"))
			SO_sig = 1
		if (findtext(signature, "Oberleutnant"))
			CO_sig = 1

	if (!QM_sig && !SO_sig && !CO_sig)
		memo = "<i>We didn't find any valid signatures, so your requisition has been rejected.</span><br>"
		goto end

	for (var/purchase in purchases)
		var/cost = costs[purchase]
		var/cratetype = crate_types[purchase]
		if (cost > train.supply_points)
			memo = "<i>Unfortunately, you did not have enough supply points left to purchase the [purchase] crate, or any of the purchases listed after it.</i><br>"
			break
		create_crates += cratetype
		train.supply_points -= cost

	for (var/obj/train_car_center/tcc in train.train_car_centers)
		for (var/obj/train_pseudoturf/tpt in tcc.forwards_pseudoturfs)
			if (locate(/obj/train_decal/cargo/outline) in get_turf(tpt))
				if (!locate(/obj/structure/closet/crate) in get_turf(tpt))
					if (create_crates.len)
						var/cratetype = pick(create_crates)
						create_crates -= cratetype

						var/tpt_turf = get_turf(tpt)

						for (var/mob/m in tpt_turf)
							qdel(m)
						for (var/obj/item/i in tpt_turf)
							qdel(i)
						for (var/obj/o in tpt_turf)
							if (o.density)
								qdel(o)

						new cratetype(tpt_turf)

	if (create_crates.len) // we didn't have enough space to send them all
		memo = "<i><br>We didn't have enough space for the crates listed below, so you were reimbursed for their cost: </i><br><br>"
		for (var/cratetype in create_crates)
			for (var/cratename in crate_types)
				if (crate_types[cratename] == cratetype)
					var/cost = costs[cratename]
					train.supply_points += cost
					memo += "<i>[cratename]</i><br>"


	end

	// add our unique memo ending
	memo += generate_memoend(train)

	signatures = list()

	purchases = list()

	regenerate_info()

	return 1
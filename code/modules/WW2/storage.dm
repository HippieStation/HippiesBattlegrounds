/obj/item/clothing/accessory/storage/webbing
	name = "webbing"
	desc = "Sturdy mess of synthcotton belts and buckles, ready to share your burden."
	icon_state = "webbing"
	slots = 8

	New()
		..()
		hold.cant_hold = list(/obj/item/clothing/accessory/storage/webbing)

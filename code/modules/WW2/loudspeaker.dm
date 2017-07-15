/obj/item/device/radio/intercom/loudspeaker
	name = "base loudspeaker"
	desc = "This is where your commandant shouts at you from."
	icon_state = "loudspeaker"
	canhear_range = 7
	listening = 0
	broadcasting = 1
	layer = MOB_LAYER + 1

/obj/item/device/radio/intercom/loudspeaker/german
	frequency = DE_BASE_FREQ

/obj/item/device/radio/intercom/loudspeaker/russian
	frequency = RU_BASE_FREQ

/obj/item/device/radio/intercom/loudspeaker/interact(mob/user)
	return //It's just a loudspeaker

/obj/item/device/radio/intercom/loudspeaker/process()
	return //to stop icon from changing

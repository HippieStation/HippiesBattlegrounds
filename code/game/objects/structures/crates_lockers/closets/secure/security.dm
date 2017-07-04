/obj/structure/closet/secure_closet/captains
	name = "captain's locker"
	req_access = list(access_captain)
	icon_state = "capsecure1"
	icon_closed = "capsecure"
	icon_locked = "capsecure1"
	icon_opened = "capsecureopen"
	icon_broken = "capsecurebroken"
	icon_off = "capsecureoff"

	New()
		..()
		if(prob(50))
			new /obj/item/weapon/storage/backpack/captain(src)
		else
			new /obj/item/weapon/storage/backpack/satchel_cap(src)
		new /obj/item/clothing/head/caphat/cap(src)
		new /obj/item/clothing/under/rank/captain(src)
		new /obj/item/clothing/suit/armor/vest(src)
		new /obj/item/weapon/cartridge/captain(src)
		new /obj/item/clothing/head/helmet(src)
		new /obj/item/clothing/shoes/color/brown(src)
		new /obj/item/device/radio/headset/heads/captain(src)
		new /obj/item/clothing/gloves/captain(src)
		new /obj/item/weapon/gun/energy/gun(src)
		new /obj/item/clothing/suit/armor/captain(src)
		new /obj/item/weapon/melee/telebaton(src)
		new /obj/item/clothing/head/caphat/formal(src)
		new /obj/item/clothing/under/captainformal(src)
		return



/obj/structure/closet/secure_closet/hop
	name = "First Officer's locker"
	req_access = list(access_hop)
	icon_state = "hopsecure1"
	icon_closed = "hopsecure"
	icon_locked = "hopsecure1"
	icon_opened = "hopsecureopen"
	icon_broken = "hopsecurebroken"
	icon_off = "hopsecureoff"

	New()
		..()
		new /obj/item/clothing/glasses/sunglasses(src)
		new /obj/item/clothing/under/rank/head_of_personnel(src)
		new /obj/item/clothing/head/caphat/hop(src)
		new /obj/item/clothing/suit/armor/vest(src)
		new /obj/item/clothing/head/helmet(src)
		new /obj/item/weapon/cartridge/hop(src)
		new /obj/item/device/radio/headset/heads/hop(src)
		new /obj/item/weapon/storage/box/ids(src)
		new /obj/item/weapon/storage/box/ids( src )
		new /obj/item/weapon/gun/energy/gun/martin(src)
		new /obj/item/device/flash(src)
		return



/obj/structure/closet/secure_closet/hos
	name = "Ironhammer Commander locker"
	req_access = list(access_hos)
	icon_state = "hossecure1"
	icon_closed = "hossecure"
	icon_locked = "hossecure1"
	icon_opened = "hossecureopen"
	icon_broken = "hossecurebroken"
	icon_off = "hossecureoff"

	New()
		..()
		if(prob(50))
			new /obj/item/weapon/storage/backpack/security(src)
		else
			new /obj/item/weapon/storage/backpack/satchel_sec(src)
		new /obj/item/clothing/head/HoS(src)
		new /obj/item/clothing/suit/armor/vest/security(src)
		new /obj/item/clothing/under/rank/ih_commander/jensen(src)
		new /obj/item/clothing/suit/armor/hos/jensen(src)
		new /obj/item/clothing/suit/armor/hos(src)
		new /obj/item/clothing/head/HoS/dermal(src)
		new /obj/item/weapon/cartridge/hos(src)
		new /obj/item/device/radio/headset/heads/hos(src)
		new /obj/item/clothing/glasses/sunglasses/sechud(src)
		new /obj/item/taperoll/police(src)
		new /obj/item/weapon/shield/riot(src)
		new /obj/item/weapon/storage/box/flashbangs(src)
		new /obj/item/weapon/storage/belt/security(src)
		new /obj/item/device/flash(src)
		new /obj/item/weapon/melee/baton/loaded(src)
		new /obj/item/weapon/gun/projectile/lamia(src)
		new /obj/item/ammo_magazine/mg/cl44/rubber(src)
		new /obj/item/ammo_magazine/mg/cl44/rubber(src)
		new /obj/item/ammo_magazine/mg/cl44/rubber(src)
		new /obj/item/clothing/accessory/holster/waist(src)
		new /obj/item/weapon/melee/telebaton(src)
		new /obj/item/clothing/head/beret/sec/navy/hos(src)
		new /obj/item/clothing/accessory/badge/hos(src)
		return



/obj/structure/closet/secure_closet/warden
	name = "Gunnery Sergeant's locker"
	req_access = list(access_armory)
	icon_state = "wardensecure1"
	icon_closed = "wardensecure"
	icon_locked = "wardensecure1"
	icon_opened = "wardensecureopen"
	icon_broken = "wardensecurebroken"
	icon_off = "wardensecureoff"


	New()
		..()
		if(prob(50))
			new /obj/item/weapon/storage/backpack/security(src)
		else
			new /obj/item/weapon/storage/backpack/satchel_sec(src)
		new /obj/item/clothing/suit/armor/vest/security(src)
		new /obj/item/clothing/under/rank/warden(src)
		new /obj/item/clothing/suit/armor/vest/serg(src)
		new /obj/item/clothing/head/warden(src)
		new /obj/item/weapon/cartridge/security(src)
		new /obj/item/device/radio/headset/headset_sec(src)
		new /obj/item/clothing/glasses/sunglasses/sechud(src)
		new /obj/item/taperoll/police(src)
		new /obj/item/weapon/storage/box/flashbangs(src)
		new /obj/item/weapon/storage/box/teargas(src)
		new /obj/item/weapon/storage/belt/security(src)
		new /obj/item/weapon/reagent_containers/spray/pepper(src)
		new /obj/item/weapon/melee/baton/loaded(src)
		new /obj/item/weapon/gun/projectile/automatic/SMG_sol(src)
		new /obj/item/ammo_magazine/SMG_sol/rubber(src)
		new /obj/item/ammo_magazine/SMG_sol/rubber(src)
		new /obj/item/ammo_magazine/SMG_sol/rubber(src)
		new /obj/item/weapon/storage/box/holobadge(src)
		new /obj/item/clothing/head/beret/sec/navy/warden(src)
		new /obj/item/clothing/accessory/badge/warden(src)
		return



/obj/structure/closet/secure_closet/security
	name = "Ironhammer Operative locker"
	req_access = list(access_brig)
	icon_state = "sec1"
	icon_closed = "sec"
	icon_locked = "sec1"
	icon_opened = "secopen"
	icon_broken = "secbroken"
	icon_off = "secoff"

	New()
		..()
		if(prob(50))
			new /obj/item/weapon/storage/backpack/security(src)
		else
			new /obj/item/weapon/storage/backpack/satchel_sec(src)
		new /obj/item/clothing/suit/armor/vest/security(src)
		new /obj/item/clothing/head/helmet(src)
		new /obj/item/clothing/head/beret/sec/navy/officer(src)
		new /obj/item/device/radio/headset/headset_sec(src)
		new /obj/item/weapon/storage/belt/security(src)
		new /obj/item/device/flash(src)
		new /obj/item/weapon/reagent_containers/spray/pepper(src)
		new /obj/item/weapon/grenade/chem_grenade/teargas(src)
		new /obj/item/weapon/melee/baton/loaded(src)
		new /obj/item/clothing/glasses/sunglasses/sechud(src)
		new /obj/item/taperoll/police(src)
		new /obj/item/device/hailer(src)
		new /obj/item/clothing/accessory/storage/black_vest(src)
		new /obj/item/weapon/gun/projectile/automatic/SMG_sol(src)
		new /obj/item/ammo_magazine/SMG_sol/rubber(src)
		new /obj/item/ammo_magazine/SMG_sol/rubber(src)
		new /obj/item/ammo_magazine/SMG_sol/rubber(src)
		return


/obj/structure/closet/secure_closet/security/cargo

	New()
		..()
		new /obj/item/clothing/accessory/armband/cargo(src)
		new /obj/item/device/encryptionkey/headset_cargo(src)
		return

/obj/structure/closet/secure_closet/security/engine

	New()
		..()
		new /obj/item/clothing/accessory/armband/engine(src)
		new /obj/item/device/encryptionkey/headset_eng(src)
		return

/obj/structure/closet/secure_closet/security/science

	New()
		..()
		new /obj/item/clothing/accessory/armband/science(src)
		new /obj/item/device/encryptionkey/headset_sci(src)
		return

/obj/structure/closet/secure_closet/security/med

	New()
		..()
		new /obj/item/clothing/accessory/armband/medgreen(src)
		new /obj/item/device/encryptionkey/headset_med(src)
		return


/obj/structure/closet/secure_closet/detective
	name = "detective's cabinet"
	req_access = list(access_forensics_lockers)
	icon_state = "cabinetdetective_locked"
	icon_closed = "cabinetdetective"
	icon_locked = "cabinetdetective_locked"
	icon_opened = "cabinetdetective_open"
	icon_broken = "cabinetdetective_broken"
	icon_off = "cabinetdetective_broken"

	New()
		..()
		new /obj/item/clothing/under/det(src)
		new /obj/item/clothing/under/det/black(src)
		new /obj/item/clothing/under/inspector(src)
		new /obj/item/clothing/suit/storage/det_trench(src)
		new /obj/item/clothing/suit/storage/det_trench/grey(src)
		new /obj/item/clothing/suit/storage/insp_trench(src)
		new /obj/item/clothing/gloves/thick(src)
		new /obj/item/clothing/head/det(src)
		new /obj/item/clothing/head/det/grey(src)
		new /obj/item/clothing/shoes/laceup(src)
		new /obj/item/weapon/storage/box/evidence(src)
		new /obj/item/device/radio/headset/headset_sec(src)
		new /obj/item/clothing/suit/armor/vest/detective(src)
		new /obj/item/taperoll/police(src)
		new /obj/item/weapon/gun/projectile/revolver/consul(src)
		new /obj/item/clothing/accessory/holster/armpit(src)
		new /obj/item/ammo_magazine/sl/cl44/rubber(src)
		new /obj/item/ammo_magazine/sl/cl44/rubber(src)
		new /obj/item/ammo_magazine/sl/cl44/rubber(src)
		return

/obj/structure/closet/secure_closet/detective/update_icon()
	if(broken)
		icon_state = icon_broken
	else
		if(!opened)
			if(locked)
				icon_state = icon_locked
			else
				icon_state = icon_closed
		else
			icon_state = icon_opened

/obj/structure/closet/secure_closet/injection
	name = "lethal injections locker"
	req_access = list(access_captain)


	New()
		..()
		new /obj/item/weapon/reagent_containers/syringe/ld50_syringe/choral(src)
		new /obj/item/weapon/reagent_containers/syringe/ld50_syringe/choral(src)
		return



/obj/structure/closet/secure_closet/brig
	name = "brig locker"
	req_access = list(access_brig)
	anchored = 1
	var/id = null

	New()
		..()
		new /obj/item/clothing/under/color/orange( src )
		new /obj/item/clothing/shoes/color/orange( src )
		return



/obj/structure/closet/secure_closet/courtroom
	name = "courtroom locker"
	req_access = list(access_lawyer)

	New()
		..()
		new /obj/item/clothing/shoes/color/brown(src)
		new /obj/item/weapon/paper/Court (src)
		new /obj/item/weapon/paper/Court (src)
		new /obj/item/weapon/paper/Court (src)
		new /obj/item/weapon/pen (src)
		new /obj/item/clothing/suit/judgerobe (src)
		new /obj/item/clothing/head/powdered_wig (src)
		new /obj/item/weapon/storage/briefcase(src)
		return

/obj/structure/closet/secure_closet/wall
	name = "wall locker"
	req_access = list(access_security)
	icon_state = "wall-locker1"
	density = 1
	icon_closed = "wall-locker"
	icon_locked = "wall-locker1"
	icon_opened = "wall-lockeropen"
	icon_broken = "wall-lockerbroken"
	icon_off = "wall-lockeroff"

	//too small to put a man in
	large = 0

/obj/structure/closet/secure_closet/wall/update_icon()
	if(broken)
		icon_state = icon_broken
	else
		if(!opened)
			if(locked)
				icon_state = icon_locked
			else
				icon_state = icon_closed
		else
			icon_state = icon_opened

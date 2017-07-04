/mob/living/silicon/robot/update_hud()
	check_HUD()
	return

/mob/living/silicon/robot/check_HUD()
	var/mob/living/silicon/robot/H = src
	if(!H.client)
		return

//	var/datum/hud/human/HUDdatum = global.HUDdatums[H.defaultHUD]
	var/recreate_flag = 0

	if(!check_HUDdatum())
		H.defaultHUD = "BorgStyle"
		++recreate_flag

	if (recreate_flag)
		H.destroy_HUD()
		H.create_HUD()

	H.show_HUD()
	return recreate_flag


/mob/living/silicon/robot/check_HUDdatum()//correct a datum?
	var/mob/living/silicon/robot/H = src

	if (H.defaultHUD == "BorgStyle") //���� � ������� ���� �������� �����\��� ����
		if(global.HUDdatums.Find(H.defaultHUD))//���� ���������� ����� ��� ����
			return 1
	return 0




/mob/living/silicon/robot/create_HUD() //EKUDZA HAS HERE
//	var/mob/living/silicon/robot/H = src
//	var/datum/hud/cyborg/HUDdatum = global.HUDdatums[H.defaultHUD]

	create_HUDneed()
	create_HUDinventory()
	create_HUDfrippery()
	create_HUDtech()
	show_HUD()
	return






/mob/living/silicon/robot/create_HUDinventory()
	var/mob/living/silicon/robot/H = src
	var/datum/hud/cyborg/HUDdatum = global.HUDdatums[H.defaultHUD]
	for (var/HUDname in HUDdatum.slot_data)
		var/HUDtype
		HUDtype = HUDdatum.slot_data[HUDname]["type"]
		var/obj/screen/inventory/inv_box = new HUDtype(HUDname, HUDdatum.slot_data[HUDname]["loc"], HUDdatum.icon,HUDdatum.slot_data[HUDname]["icon_state"],H, HUDdatum.slot_data.Find(HUDname))
		H.HUDinventory += inv_box
	return



/mob/living/silicon/robot/create_HUDneed()
	var/mob/living/silicon/robot/H = src
	var/datum/hud/cyborg/HUDdatum = global.HUDdatums[H.defaultHUD]
	for (var/HUDname in HUDdatum.HUDneed)
		var/HUDtype = HUDdatum.HUDneed[HUDname]["type"]
		var/obj/screen/HUD = new HUDtype(HUDname, HUDdatum.HUDneed[HUDname]["loc"], H)
		if(HUDdatum.HUDneed[HUDname]["icon"])//������ �� �������� icon
			HUD.icon = HUDdatum.HUDneed[HUDname]["icon"]
		else
			HUD.icon = HUDdatum.icon
		if(HUDdatum.HUDneed[HUDname]["icon_state"])//������ �� �������� icon_state
			HUD.icon_state = HUDdatum.HUDneed[HUDname]["icon_state"]
		H.HUDneed[HUD.name] += HUD//��������� � ������ �����
		if (HUD.process_flag)//���� ��� ����� ����������
			H.HUDprocess += HUD//������� � �������������� ������
	return



/mob/living/silicon/robot/create_HUDfrippery()
	var/mob/living/silicon/robot/H = src
	var/datum/hud/cyborg/HUDdatum = global.HUDdatums[H.defaultHUD]
	//��������� �������� ���� (���������)
	for (var/list/whistle in HUDdatum.HUDfrippery)
		var/obj/screen/frippery/perdelka = new (whistle["icon_state"],whistle["loc"], whistle["dir"],H)
		perdelka.icon = HUDdatum.icon
		H.HUDfrippery += perdelka
	return



/mob/living/silicon/robot/create_HUDtech()
	var/mob/living/silicon/robot/H = src
	var/datum/hud/cyborg/HUDdatum = global.HUDdatums[H.defaultHUD]
	//��������� ����������� ��������(damage,flash,pain... �������)
	for (var/techobject in HUDdatum.HUDoverlays)
		var/HUDtype = HUDdatum.HUDoverlays[techobject]["type"]
		var/obj/screen/HUD = new HUDtype(techobject, HUDdatum.HUDoverlays[techobject]["loc"], H)
		if(HUDdatum.HUDoverlays[techobject]["icon"])//������ �� �������� icon
			HUD.icon = HUDdatum.HUDoverlays[techobject]["icon"]
		else
			HUD.icon = HUDdatum.icon
		if(HUDdatum.HUDoverlays[techobject]["icon_state"])//������ �� �������� icon_state
			HUD.icon_state = HUDdatum.HUDoverlays[techobject]["icon_state"]
		H.HUDtech[HUD.name] += HUD//��������� � ������ �����
		if (HUD.process_flag)//���� ��� ����� ����������
			H.HUDprocess += HUD//������� � �������������� ������
	return








/mob/living/silicon/robot/proc/toggle_show_robot_modules()
	if(!isrobot(src))
		return

	var/mob/living/silicon/robot/r = src

	r.shown_robot_modules = !r.shown_robot_modules
	update_robot_modules_display()


/mob/living/silicon/robot/proc/update_robot_modules_display()
	if(!isrobot(src))
		return

	var/mob/living/silicon/robot/r = src

	if(r.shown_robot_modules)
		//Modules display is shown
		//r.client.screen += robot_inventory	//"store" icon

		if(!r.module)
			usr << "<span class='danger'>No module selected</span>"
			return

		if(!r.module.modules)
			usr << "<span class='danger'>Selected module has no modules to select</span>"
			return

		if(!r.robot_modules_background)
			return

		var/display_rows = -round(-(r.module.modules.len) / 8)
		r.robot_modules_background.screen_loc = "CENTER-4:16,SOUTH+1:7 to CENTER+3:16,SOUTH+[display_rows]:7"
		r.client.screen += r.robot_modules_background

		var/x = -4	//Start at CENTER-4,SOUTH+1
		var/y = 1

		//Unfortunately adding the emag module to the list of modules has to be here. This is because a borg can
		//be emagged before they actually select a module. - or some situation can cause them to get a new module
		// - or some situation might cause them to get de-emagged or something.
		if(r.emagged)
			if(!(r.module.emag in r.module.modules))
				r.module.modules.Add(r.module.emag)
		else
			if(r.module.emag in r.module.modules)
				r.module.modules.Remove(r.module.emag)

		for(var/atom/movable/A in r.module.modules)
			if( (A != r.module_state_1) && (A != r.module_state_2) && (A != r.module_state_3) )
				//Module is not currently active
				r.client.screen += A
				if(x < 0)
					A.screen_loc = "CENTER[x]:16,SOUTH+[y]:7"
				else
					A.screen_loc = "CENTER+[x]:16,SOUTH+[y]:7"
				A.layer = 20

				x++
				if(x == 4)
					x = -4
					y++

	else
		//Modules display is hidden
		//r.client.screen -= robot_inventory	//"store" icon
		for(var/atom/A in r.module.modules)
			if( (A != r.module_state_1) && (A != r.module_state_2) && (A != r.module_state_3) )
				//Module is not currently active
				r.client.screen -= A
		r.shown_robot_modules = 0
		r.client.screen -= r.robot_modules_background
//-----------------------ROBOT stuff---------------------
/obj/screen/silicon
	name = "silicon button"
	icon = 'icons/mob/screen1_robot.dmi'


/obj/screen/silicon/radio
	name = "radio"
	icon_state = "radio"

/obj/screen/silicon/radio/Click()
	usr:radio_menu()



/obj/screen/silicon/panel
	name = "panel"
	icon_state = "panel"

/obj/screen/silicon/panel/Click()
	usr:installed_modules()

/obj/screen/silicon/store
	name = "store"
	icon_state = "store"

/obj/screen/silicon/store/Click()
	var/mob/living/silicon/robot/R = usr
	if(R.module)
		R.uneq_active()
		R.update_robot_modules_display()
	else
		R << "You haven't selected a module yet."

/obj/screen/silicon/module
	name = "moduleNo"
	icon_state = "inv1"
	var/module_num
	var/icon/underlay_icon = new ('icons/mob/screen1_robot.dmi', "inv_active")

/obj/screen/silicon/module/New(_name = "unnamed", _screen_loc = "7,7", _icon , _icon_state,mob/living/_parentmob, _module_num)
	..(_name, _screen_loc, _parentmob)
	module_num = _module_num
	src.icon_state = _icon_state
	src.icon = _icon
	update_icon()

/obj/screen/silicon/module/update_icon()
	underlays.Cut()
	var/mob/living/silicon/robot/R = parentmob
	if(!R.module_active(module_num)) return
	switch(module_num)
		if(1)
			if(R.module_active == R.module_state_1)
				underlays += underlay_icon
				return
		if(2)
			if(R.module_active == R.module_state_2)
				underlays += underlay_icon
				return
		if(3)
			if(R.module_active == R.module_state_3)
				underlays += underlay_icon
				return


/obj/screen/silicon/module/Click()
	parentmob:toggle_module(module_num)

/obj/screen/silicon/cell
	name = "cell"
	icon_state = "charge0"
	process_flag = 1

/obj/screen/silicon/cell/process()
	update_icon()

/obj/screen/silicon/cell/update_icon()
	var/mob/living/silicon/robot/R = parentmob
	if (R.cell)
		var/cellcharge = R.cell.charge/R.cell.maxcharge
		switch(cellcharge)
			if(0.75 to INFINITY)
				icon_state = "charge4"
			if(0.5 to 0.75)
				icon_state = "charge3"
			if(0.25 to 0.5)
				icon_state = "charge2"
			if(0 to 0.25)
				icon_state = "charge1"
			else
				icon_state = "charge0"
	else
		icon_state = "charge-empty"

/obj/screen/health/cyborg/process() //TO:DO ������� ������ ������� ����������� ��������.
	if (parentmob.stat != 2)
		if(isdrone(parentmob))
			switch(parentmob.health)
				if(35 to INFINITY)
					icon_state = "health0"
				if(25 to 34)
					icon_state = "health1"
				if(15 to 24)
					icon_state = "health2"
				if(5 to 14)
					icon_state = "health3"
				if(0 to 4)
					icon_state = "health4"
				if(-35 to 0)
					icon_state = "health5"
				else
					icon_state = "health6"
		else
			switch(parentmob.health)
				if(200 to INFINITY)
					icon_state = "health0"
				if(150 to 200)
					icon_state = "health1"
				if(100 to 150)
					icon_state = "health2"
				if(50 to 100)
					icon_state = "health3"
				if(0 to 50)
					icon_state = "health4"
				if(config.health_threshold_dead to 0)
					icon_state = "health5"
				else
					icon_state = "health6"
	else
		icon_state = "health7"


/obj/screen/silicon/module_select
	name = "module"
	icon_state = "nomod"

/obj/screen/silicon/module_select/Click()
	if(isrobot(parentmob))
		var/mob/living/silicon/robot/R = parentmob
		if(R.module)
			R.toggle_show_robot_modules()
			return 1
		R.pick_module()
		update_icon()

/obj/screen/silicon/module_select/update_icon()
	var/mob/living/silicon/robot/R = parentmob
	icon_state = lowertext(R.modtype)

/obj/screen/silicon/inventory
	name = "inventory"
	icon_state = "inventory"

/obj/screen/silicon/inventory/Click()
	if(isrobot(parentmob))
		var/mob/living/silicon/robot/R = parentmob
		if(R.module)
			R.toggle_show_robot_modules()
			return 1
		else
			R << "You haven't selected a module yet."
//-----------------------ROBOT stuff end---------------------
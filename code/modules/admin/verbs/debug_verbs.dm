
var/list/debug_verbs = list (
      //  /client/proc/do_not_use_these
        ,/client/proc/Cell
        ,/client/proc/count_objects_on_z_level
        ,/client/proc/count_objects_all
        ,/client/proc/cmd_assume_direct_control
        ,/client/proc/jump_to_dead_group
        ,/client/proc/startSinglo
        ,/client/proc/ticklag
        ,/client/proc/kaboom
        ,/client/proc/cmd_admin_areatest
        ,/client/proc/cmd_admin_rejuvenate
        ,/datum/admins/proc/show_traitor_panel
        ,/client/proc/print_jobban_old
        ,/client/proc/print_jobban_old_filter
     //   ,/client/proc/break_all_air_groups
      //  ,/client/proc/regroup_all_air_groups
      //  ,/client/proc/kill_pipe_processing
      //  ,/client/proc/kill_air_processing
        ,/client/proc/disable_communication
        ,/client/proc/disable_movement
  //      ,/client/proc/Zone_Info
 //       ,/client/proc/Test_ZAS_Connection
  //      ,/client/proc/ZoneTick
 //       ,/client/proc/rebootAirMaster
        ,/client/proc/hide_debug_verbs
 //       ,/client/proc/testZAScolors
    //    ,/client/proc/testZAScolors_remove
	//	,/client/proc/spawn_tanktransferbomb
	)


/client/proc/enable_debug_verbs()
	set category = "Debug"
	set name = "Debug verbs"

	if(!check_rights(R_DEBUG)) return

	verbs += debug_verbs



/client/proc/hide_debug_verbs()
	set category = "Debug"
	set name = "Hide Debug verbs"

	if(!check_rights(R_DEBUG)) return

	verbs -= debug_verbs

//This proc is intended to detect lag problems relating to communication procs
var/global/say_disabled = 0
/client/proc/disable_communication()
	set category = "Mapping"
	set name = "Disable all communication verbs"

	usr << "\red Proc disabled."

	/*say_disabled = !say_disabled
	if(say_disabled)
		message_admins("[src.ckey] used 'Disable all communication verbs', killing all communication methods.")
	else
		message_admins("[src.ckey] used 'Disable all communication verbs', restoring all communication methods.")*/

//This proc is intended to detect lag problems relating to movement
var/global/movement_disabled = 0
var/global/movement_disabled_exception //This is the client that calls the proc, so he can continue to run around to gauge any change to lag.
/client/proc/disable_movement()
	set category = "Mapping"
	set name = "Disable all movement"

	usr << "\red Proc disabled."

	/*movement_disabled = !movement_disabled
	if(movement_disabled)
		message_admins("[src.ckey] used 'Disable all movement', killing all movement.")
		movement_disabled_exception = usr.ckey
	else
		message_admins("[src.ckey] used 'Disable all movement', restoring all movement.")*/

/mob
	var/obj/screen/plane/master/master_plane
	var/obj/screen/plane/dark/dark_plane

/mob/Login()
	. = ..()
	if(!dark_plane)
		dark_plane = new(client)
	else
		client.screen |= dark_plane
	if(!master_plane)
		master_plane = new(client)
	else
		client.screen |= master_plane

/mob/observer/ghost/Login()
	. = ..()
	if(client)
		if(seedarkness)
			client.screen |= dark_plane
			client.screen |= master_plane
		else
			client.screen -= dark_plane
			client.screen -= master_plane

/mob/living/carbon/human/update_contained_lights(var/list/specific_contents)
	. = ..(contents-(internal_organs+organs))

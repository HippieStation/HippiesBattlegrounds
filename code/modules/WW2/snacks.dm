/obj/item/weapon/reagent_containers/food/snacks/pervitinchocolatebar
	name = "Panzerschokolade bar"
	desc = "Such sweet, fattening food. You feel so empowered after tasting it!"
	icon_state = "chocolatebar"
	filling_color = "#7D5F46"

	New()
		..()
		reagents.add_reagent("pervitin", 1)
		reagents.add_reagent("nutriment", 2)
		reagents.add_reagent("sugar", 2)
		reagents.add_reagent("coco", 2)
		bitesize = 2


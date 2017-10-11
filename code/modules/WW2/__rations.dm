/* the only reason this exists is because apparently 'new pick(listoftypes)'
	is invalid code - Kachnov */

var/added_plants_to_rations = 0

/proc/new_ration(faction, sort)

	if (!added_plants_to_rations)
		german_rations_solids += typesof(/obj/item/weapon/reagent_containers/food/snacks/grown) - /obj/item/weapon/reagent_containers/food/snacks/grown
		soviet_rations_solids += typesof(/obj/item/weapon/reagent_containers/food/snacks/grown) - /obj/item/weapon/reagent_containers/food/snacks/grown

	switch (faction)
		if (GERMAN)
			switch (sort)
				if ("solid")
					var/solid = pick(german_rations_solids)
					var/obj/food = new solid
					food.pixel_x = 0
					food.pixel_y = 0
					return food
				if ("liquid")
					var/liquid = pick(german_rations_liquids)
					var/obj/food = new liquid
					food.pixel_x = 0
					food.pixel_y = 0
					return food
				if ("dessert")
					var/dessert = pick(german_rations_desserts)
					var/obj/food = new dessert
					food.pixel_x = 0
					food.pixel_y = 0
					return food
				if ("meat")
					var/meat = pick(german_rations_meat)
					var/obj/food = new meat
					food.pixel_x = 0
					food.pixel_y = 0
					return food
		if (RUSSIAN)
			switch (sort)
				if ("solid")
					var/solid = pick(soviet_rations_solids)
					var/obj/food = new solid
					food.pixel_x = 0
					food.pixel_y = 0
					return food
				if ("liquid")
					var/liquid = pick(soviet_rations_liquids)
					var/obj/food = new liquid
					food.pixel_x = 0
					food.pixel_y = 0
					return food
				if ("dessert")
					var/dessert = pick(soviet_rations_desserts)
					var/obj/food = new dessert
					food.pixel_x = 0
					food.pixel_y = 0
					return food
				if ("meat")
					var/meat = pick(soviet_rations_meat)
					var/obj/food = new meat
					food.pixel_x = 0
					food.pixel_y = 0
					return food

// GERMAN RATIONS

var/list/german_rations_solids = list(/obj/item/weapon/reagent_containers/food/snacks/sliceable/bread,
/obj/item/weapon/reagent_containers/food/snacks/sliceable/cheesewheel,
/obj/item/weapon/reagent_containers/food/snacks/sandwich,
/obj/item/weapon/reagent_containers/food/snacks/mint,
/obj/item/weapon/reagent_containers/food/snacks/sausage
)

var/list/german_rations_liquids = list(
/obj/item/weapon/reagent_containers/food/snacks/mushroomsoup,
/obj/item/weapon/reagent_containers/food/snacks/stew,
)

var/list/german_rations_desserts = list(
/obj/item/weapon/reagent_containers/food/snacks/sliceable/carrotcake,
/obj/item/weapon/reagent_containers/food/snacks/appletart,
)

var/list/german_rations_meat = list(
/obj/item/weapon/reagent_containers/food/snacks/meat
)

// soviet RATIONS

var/list/soviet_rations_solids = list(/obj/item/weapon/reagent_containers/food/snacks/sliceable/bread,
/obj/item/weapon/reagent_containers/food/snacks/sliceable/cheesewheel,
/obj/item/weapon/reagent_containers/food/snacks/sandwich,
/obj/item/weapon/reagent_containers/food/snacks/mint,
/obj/item/weapon/reagent_containers/food/snacks/cutlet
)

var/list/soviet_rations_liquids = list(
/obj/item/weapon/reagent_containers/food/snacks/mushroomsoup,
/obj/item/weapon/reagent_containers/food/snacks/beetsoup,
)

// blin no dessert in mother russia
var/list/soviet_rations_desserts = list(

)

var/list/soviet_rations_meat = list(
/obj/item/weapon/reagent_containers/food/snacks/bearmeat,
/obj/item/weapon/reagent_containers/food/snacks/meat
)

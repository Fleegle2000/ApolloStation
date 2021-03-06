/mob/living/simple_animal/hostile/broodling
	name = "\improper Broodling"
	desc = "For the hive!"
	icon = 'icons/mob/broodling.dmi'
	icon_state = "broodling"
	icon_living = "broodling"
	icon_dead = "broodling_dead"
	icon_gib = "broodling_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 4
	move_speed = 40
	stop_automated_movement_when_pulled = 0
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "punched"
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/mobcorpse/broodling
	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	unsuitable_atoms_damage = 15
	wall_smash = 1
	faction = "broodling"
	status_flags = CANPUSH

/mob/living/simple_animal/hostile/broodling/death()
	..()
	if(corpse)
		new corpse (src.loc)
	del src
	return

/mob/living/simple_animal/hostile/broodling/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(O.force)
		if(prob(80))
			var/damage = O.force
			if (O.damtype == HALLOSS)
				damage = 0
			health -= damage
			visible_message("\red \b [src] has been attacked with the [O] by [user]. ")
		else
			visible_message("\red \b [src] absorbs the hit from [O], taking no visible damage! ")
	else
		usr << "\red This weapon is ineffective, it does no damage."
		visible_message("\red [user] gently taps [src] with the [O]. ")


/mob/living/simple_animal/hostile/broodling/melee/bullet_act(var/obj/item/projectile/Proj)
	if(!Proj)	return
	if(Proj.damage >= health/2) // Gotta soften them up a bit first before you can knock em down
		src.health -= Proj.damage
	else
		visible_message("\blue <B>[Proj] bounces off of [src], leaving it unharmed!</B>")
	return 0

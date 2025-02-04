extends Node2D

var dirt_loot = [preload("res://scenes/items/vomit.tscn"),
				 preload("res://scenes/items/anchor.tscn"),
				 preload("res://scenes/items/cigarette.tscn"),
				 preload("res://scenes/items/symbol.tscn"),
				 preload("res://scenes/items/cash.tscn")]

var common_loot = []
var rare_loot = []
var unheardof_loot = []
var superultralegendary_loot = []

func get_drop(rarity):
	if rarity == "dirt":
		return dirt_loot.pick_random().instantiate()
	elif rarity == "common":
		return common_loot.pick_random().instantiate()
	elif rarity == "rare":
		return rare_loot.pick_random().instantiate()
	elif rarity == "unheard-of":
		return unheardof_loot.pick_random().instantiate()
	elif rarity == "super-ultra-legendary":
		return superultralegendary_loot.pick_random().instantiate()

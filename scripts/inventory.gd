extends Node2D

var weapons = []
var equipment = []
var carried = []
var mucus = 0
var god = 0
var cigarettes = 0
var delusion = 0
var shark = 0
var inspected_item = null
var scream_scene = preload('res://scenes/items/the_scream.tscn')
var inventoryslot_scene = preload('res://scenes/inventoryslot.tscn')
@onready var playerstats = $unlocatednode/mainpanel/statsdisplay
@onready var weaponsgrid = $unlocatednode/mainpanel/weaponsgrid
@onready var equipmentgrid = $unlocatednode/mainpanel/equipmentgrid
@onready var carriedgrid = $unlocatednode/mainpanel/carriedgrid
@onready var inventorypanel = $unlocatednode/mainpanel
@onready var detailswindow = $unlocatednode/mainpanel/detailswindow
@onready var detailsname = $unlocatednode/mainpanel/detailswindow/name
@onready var detailsicon = $unlocatednode/mainpanel/detailswindow/icon
@onready var detailsstats = $unlocatednode/mainpanel/detailswindow/stats
@onready var detailsdesc = $unlocatednode/mainpanel/detailswindow/description
@onready var detailsequipbutton = $unlocatednode/mainpanel/detailswindow/equipbutton
@onready var scream = scream_scene.instantiate()

func _ready():
	equip_weapon(scream)

func get_items():
	return equipment + weapons

func reload_stats():
	mucus = 0
	god = 0
	cigarettes = 0
	delusion = 0
	shark = 0
	for item in weapons:
		mucus += item.mucus
		god += item.god
		cigarettes += item.cigarettes
		delusion += item.delusion
		shark += item.shark
	for item in equipment:
		mucus += item.mucus
		god += item.god
		cigarettes += item.cigarettes
		delusion += item.delusion
		shark += item.shark
	playerstats.text = "mucus:\t\t\t%s\ngod:\t\t\t\t\t%s\ncigarettes:\t\t%s\ndelusion:\t\t%s\nshark:\t\t\t\t%s" % [mucus, god, cigarettes, delusion, shark]

func equip_item(item):
	equipment.append(item)
	var slot = inventoryslot_scene.instantiate()
	equipmentgrid.add_child(slot)
	slot.set_item(item)
	self.add_child(item)
	remove_carried(item)
	reload_stats()

func unequip_item(item):
	add_carried(item)
	self.remove_child(item)
	equipment.erase(item)
	for slot in equipmentgrid.get_children():
		if slot.item == item:
			equipmentgrid.remove_child(slot)
	reload_stats()

func equip_weapon(item):
	if weapons.size() < 3:
		if item.is_weapon:
			weapons.append(item)
			remove_carried(item)
			self.add_child(item)
			var slot = inventoryslot_scene.instantiate()
			weaponsgrid.add_child(slot)
			slot.set_item(item)
	reload_stats()

func unequip_weapon(item):
	add_carried(item)
	self.remove_child(item)
	weapons.erase(item)
	for slot in weaponsgrid.get_children():
		if slot.item == item:
			weaponsgrid.remove_child(slot)
	reload_stats()

func add_carried(item):
	carried.append(item)
	var slot = inventoryslot_scene.instantiate()
	carriedgrid.add_child(slot)
	slot.set_item(item)

func remove_carried(item):
	# not an error if item is not in carried
	carried.erase(item)
	for slot in carriedgrid.get_children():
		if slot.item == item:
			carriedgrid.remove_child(slot)

func _input(event):
	if event.is_action_pressed("inventory"):
		if get_tree().paused:
			get_tree().paused = false
			inventorypanel.hide()
		else:
			get_tree().paused = true
			inventorypanel.show()

func show_details(item):
	inspected_item = item
	detailsname.text = "[center]" + item.item_name + "[/center]"
	detailsicon.texture = item.icon
	detailsstats.text = "mucus:\t\t\t%s\ngod:\t\t\t\t\t%s\ncigarettes:\t\t%s\ndelusion:\t\t%s\nshark:\t\t\t\t%s" % [item.mucus, item.god, item.cigarettes, item.delusion, item.shark]
	detailsdesc.text = item.tooltip
	if item in weapons or item in equipment:
		detailsequipbutton.text = "unequip"
	else:
		detailsequipbutton.text = "equip"
	detailswindow.show()

func _on_closebutton_pressed():
	detailswindow.hide()

func _on_dropbutton_pressed():
	if inspected_item in weapons:
		unequip_weapon(inspected_item)
	elif inspected_item in equipment:
		unequip_item(inspected_item)
	remove_carried(inspected_item)
	detailswindow.hide()

func _on_equipbutton_pressed():
	if inspected_item in weapons:
		unequip_weapon(inspected_item)
	elif inspected_item in equipment:
		unequip_item(inspected_item)
	else:
		if inspected_item.is_weapon:
			equip_weapon(inspected_item)
		else:
			equip_item(inspected_item)
	detailswindow.hide()

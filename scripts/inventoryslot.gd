extends Button

var item = null
@onready var texture = $TextureRect
@onready var inventory = get_parent().get_parent().get_parent().get_parent() # TODO: improve this

func set_item(itm: Item):
	if itm == null:
		item = null
		tooltip_text = ""
		texture.texture = null
	else:
		item = itm
		tooltip_text = itm.item_name
		texture.texture = itm.icon


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed == false and item != null:
		if event.button_index == 2: # right click
			if get_parent().name == "weaponsgrid":
				inventory.unequip_weapon(item)
			elif get_parent().name == "equipmentgrid":
				inventory.unequip_item(item)
			elif get_parent().name == "carriedgrid":
				if item.is_weapon:
					inventory.equip_weapon(item)
				else:
					inventory.equip_item(item)

func _on_pressed():
	inventory.show_details(item)

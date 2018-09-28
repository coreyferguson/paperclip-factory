extends PanelContainer

var build_item_hover_requirement_resource = load('res://ui/BuildItemHoverRequirement.tscn')

onready var container = $'MarginContainer/VBoxContainer/RequirementsContainer'
onready var shortcut = $'MarginContainer/VBoxContainer/spacer/HBoxContainer/Shortcut'

func _process(delta):
	rect_position = get_global_mouse_position() + Vector2(50, -25)

func _on_BuildMenu_hover_in(build_item):
	$MarginContainer/VBoxContainer/Description.text = build_item.description
	for index in range(build_item.required_item_types.size()):
		var type = build_item.required_item_types[index]
		var quantity = build_item.required_item_quantities[index]
		if build_item.hotkey_text: shortcut.text = build_item.hotkey_text
		var build_item_hover_requirement_instance = build_item_hover_requirement_resource.instance()
		build_item_hover_requirement_instance.resource = resource.get(type).icon
		build_item_hover_requirement_instance.quantity = str(quantity)
		container.add_child(build_item_hover_requirement_instance)
	visible = true

func _on_BuildMenu_hover_out(build_item):
	visible = false
	for child in container.get_children():
		container.remove_child(child)
	rect_size.y = 0

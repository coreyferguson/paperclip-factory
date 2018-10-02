extends Node

signal change

var capacity = 8
var items = []
var resource

func _init():
	for i in range(capacity):
		items.push_back(null)

func _ready():
	if has_node('/root/resource'): resource = get_node('/root/resource')
	else: resource = load('res://gamestates/game/Resource.gd').new()
	reset()

func add(item):
	for index in range(capacity):
		if items[index] != null and items[index].type == item.type:
			items[index].quantity += item.quantity
			emit_signal('change')
			return true
	for index in range(capacity):
		if items[index] == null:
			items[index] = item
			emit_signal('change')
			return true
	return false

func remove(type, quantity):
	for index in range(capacity):
		if items[index] != null and items[index].type == type:
			items[index].quantity -= quantity
			if items[index].quantity == 0: items[index] = null
			emit_signal('change')
			return true
	return false

func has(type):
	for item in items:
		if item && item.type == type: return true
	return false

func get(type):
	for item in items:
		if item && item.type == type: return item
	return null

func reset():
	for i in range(capacity):
		items[i] = null
	items[0] = {
		'type': 'energy',
		'quantity': 30,
		'texture': resource.get('energy').world_texture
	}
#	items[1] = {
#		'type': 'organic',
#		'quantity': 100,
#		'texture': resource.get('organic').world_texture
#	}

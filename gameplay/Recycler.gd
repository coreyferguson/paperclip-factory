extends KinematicBody2D

var recycle_quantity_rate = 10

var recycle_timer_wait_time = 5
var progress_bar_timer_wait_time = 1

onready var progress_bar = $ProgressBar
onready var progress_bar_timer = $ProgressBarTimer
onready var recycle_area = $RecycleArea

func _ready():
	reset_timer_wait_time()
	progress_bar_timer.start()
	Globals.connect('game_rate_change', self, 'reset_timer_wait_time')
	Player.add_building(self)

func _on_ProgressBarTimer_timeout():
	progress_bar.set_current(progress_bar.current + 1)
	if progress_bar.current == recycle_timer_wait_time:
		recycle_other()

func recycle_other():
	progress_bar.set_current(0)
	var target
	for node in recycle_area.get_overlapping_bodies():
		if node.has_method('recycle'):
			target = node
			break
#
	if target:
		var recycled_resources = target.recycle()
		for resource in recycled_resources:
			Inventory.add({
				'type': resource.type,
				'quantity': resource.quantity,
				'texture': NaturalResource.types[resource.type].world_texture
			})
	else:
		var required_resources = get_required_resources()
		for resource in required_resources:
			Inventory.add({
				'type': resource.type,
				'quantity': resource.quantity,
				'texture': NaturalResource.types[resource.type].world_texture
			})
		Player.remove_building(self)

func get_required_resources():
	var required_resources = Build.Items['Recycler'].required_resources
	if typeof(required_resources) == TYPE_OBJECT: required_resources = required_resources.call_func(Science)
	return required_resources

func kill():
	Player.remove_building(self)

func reset_timer_wait_time():
	progress_bar_timer.wait_time = 1.0 * progress_bar_timer_wait_time / Globals.game_rate

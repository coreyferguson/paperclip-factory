extends Node

signal add_enemy(enemy)
signal remove_enemy(enemy)

var enemies = []

func add_enemy(enemy):
	print('add_enemy: ', enemy.get_instance_id())
	$'/root/Game'.add_child(enemy)
	enemies.push_back(enemy)
	emit_signal('add_enemy', enemy)

func remove_enemy(enemy):
	print('remove_enemy: ', enemy.get_instance_id())
	enemies.remove(enemies.find(enemy))
	emit_signal('remove_enemy', enemy)
	enemy.queue_free()

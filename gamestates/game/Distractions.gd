extends Node

signal wave_trigger_change

var types = {
	'scout': {
		'level': 0,
		'resources': [
			load('res://gameplay/Scout_0.tscn'),
			load('res://gameplay/Scout_1.tscn')
		]
	},
	'fly': {
		'level': 0,
		'resources': [
			load('res://gameplay/Fly_0.tscn'),
			load('res://gameplay/Fly_1.tscn')
		]
	},
	'boomerang': {
		'level': 0,
		'resources': [
			load('res://gameplay/Boomerang.tscn')
		]
	},
	'carrier': {
		'level': 0,
		'resources': [
			load('res://gameplay/Carrier.tscn')
		]
	}
}

var current_wave = -1
var wave_trigger = 10 # target Globals.elapsed_time at which to spawn a wave of distractions
var wave_trigger_increment = 90 # seconds between each wave of distractions

var waves = [
	{
		'distractions': [
			{ 'type': 'scout', 'quantity': 1 }
		]
	},
	{
		'distractions': [
			{ 'type': 'scout', 'quantity': 1 },
			{ 'type': 'fly', 'quantity': 1 }
		]
	},
	{
		'distractions': [
			{ 'type': 'scout', 'quantity': 4 }
		]
	},
	{
		'distractions': [
			{ 'type': 'fly', 'quantity': 6 }
		]
	},
	{
		'distractions': [
			{ 'type': 'scout', 'quantity': 8 }
		]
	},
	{
		'distractions': [
			{ 'type': 'boomerang', 'quantity': 10 }
		]
	},
	{
		'upgrades': [ 'scout' ],
		'distractions': [
			{ 'type': 'scout', 'quantity': 6 },
			{ 'type': 'fly', 'quantity': 6 }
		]
	},
	{
		'distractions': [
			{ 'type': 'carrier', 'quantity': 1 }
		]
	},
	{
		'distractions': [
			{ 'type': 'scout', 'quantity': 14 }
		]
	},
	{
		'upgrades': [ 'fly' ],
		'distractions': [
			{ 'type': 'fly', 'quantity': 10 }
		]
	}
]

func increment_wave_trigger():
	wave_trigger += wave_trigger_increment
	current_wave += 1
	emit_signal('wave_trigger_change')

func reset():
	current_wave = -1
	for i in types:
		types[i].level = 0

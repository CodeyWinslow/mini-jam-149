extends Control

func _ready():
	print("loaded main menu")

func _on_start_game_pressed():
	print("start game pressed")
	get_tree().change_scene_to_file("res://scenes/scene_gameplay.tscn")

func _on_credits_pressed():
	print("credits pressed")
	get_tree().change_scene_to_file("res://scenes/credits_menu.tscn")

func _on_quit_pressed():
	print("quit pressed")
	get_tree().quit()

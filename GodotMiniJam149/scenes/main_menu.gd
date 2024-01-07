extends Control

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://scenes/scene_test_anim.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()

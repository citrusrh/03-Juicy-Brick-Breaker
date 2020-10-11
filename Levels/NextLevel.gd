extends Control


func _on_Next_pressed():
	get_tree().change_scene("res://Levels/Level2.tscn")


func _on_Quit_pressed():
	get_tree().quit()

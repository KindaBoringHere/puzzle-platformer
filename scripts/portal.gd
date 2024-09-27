extends Node2D
var body_entered
signal finished_level
func _ready() -> void:
	$portal_sprite.play("looping")

func _on_pulling_area_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		finished_level.emit()

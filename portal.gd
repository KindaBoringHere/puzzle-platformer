extends Node2D
var body_entered

func _ready() -> void:
	$portal_sprite.play("looping")

func _on_pulling_area_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass #finish level func

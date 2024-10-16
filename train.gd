extends PathFollow3D
@export var speed := 1.0
@export var starting_track : TrackSegment


func _process(delta: float) -> void:
	progress += speed * delta

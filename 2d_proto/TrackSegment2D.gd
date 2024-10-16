extends Node2D
class_name TrackSegment2D


@export var paths : Array[Path2D]

func get_track_path(num := 0) -> Path2D:
	if num <= len(paths):
		return paths[num]
	else:
		return paths[0]

@export var next_segment : TrackSegment2D

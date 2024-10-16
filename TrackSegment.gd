extends Node3D
class_name TrackSegment3D


@export var paths : Array[Path3D]

func get_track_path(num := 0) -> Path3D:
	if num <= len(paths):
		return paths[num]
	else:
		return paths[0]

@export var next_segment : TrackSegment3D

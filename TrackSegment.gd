extends Node3D
class_name TrackSegment


@export var paths : Array[Path3D]

func get_track_path(num := 0):
	return paths[num]

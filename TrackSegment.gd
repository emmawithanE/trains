extends Node3D
class_name TrackSegment3D

var path: Curve3D:
	get:
		if $Path3D:
			return $Path3D.curve
		print("No path on track segment!")
		return null

@export var next_segment : TrackSegment3D

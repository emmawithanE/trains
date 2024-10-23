extends Node3D
class_name Train3D

@export var starting_segment : TrackSegment3D

var current_segment : TrackSegment3D

var running := false
const SPEED = 2

func _ready() -> void:
	if starting_segment:
		$Path3D.curve = get_global_path(starting_segment)
		current_segment = starting_segment
		running = true

func get_global_path(segment : TrackSegment3D) -> Curve3D:
	var curve := segment.path.duplicate()
	for i in range(curve.point_count):
		print(curve.get_point_position(i))
		curve.set_point_position(i, segment.to_global(curve.get_point_position(i)))
	return curve
	

func _process(delta: float) -> void:
	if running:
		$Path3D/PathFollow3D.progress += SPEED * delta
	if $Path3D/PathFollow3D.progress_ratio > 0.95:
		append_next_segment()

func append_next_segment():
	if !current_segment.next_segment:
		return
	var next_segment := current_segment.next_segment
	var next_path := get_global_path(next_segment)
	
	$Path3D.curve.set_point_out($Path3D.curve.point_count - 1, next_path.get_point_out(0).rotated(Vector3.UP, next_segment.rotation.y))
	
	for i in range(1,next_path.point_count):
		$Path3D.curve.add_point(
			next_path.get_point_position(i),
			next_path.get_point_in(i).rotated(Vector3.UP, next_segment.rotation.y),
			next_path.get_point_out(i).rotated(Vector3.UP, next_segment.rotation.y)
		)
	
	current_segment = next_segment

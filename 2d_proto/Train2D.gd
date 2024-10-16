extends Node2D
class_name Train2D

@export var starting_segment : TrackSegment2D

var current_segment : TrackSegment2D

var running := false
const SPEED = 60

func _ready() -> void:
	if starting_segment:
		$Path2D.curve = get_global_path(starting_segment)
		current_segment = starting_segment
		running = true

func get_global_path(segment : TrackSegment2D) -> Curve2D:
	var curve := segment.get_track_path().curve.duplicate()
	for i in range(curve.point_count):
		curve.set_point_position(i, segment.to_global(curve.get_point_position(i)))
	return curve
	

func _process(delta: float) -> void:
	if running:
		$Path2D/PathFollow2D.progress += SPEED * delta
	if $Path2D/PathFollow2D.progress_ratio > 0.95:
		append_next_segment()

func append_next_segment():
	if !current_segment.next_segment:
		return
	var next_segment := current_segment.next_segment
	var next_path := get_global_path(next_segment)
	
	$Path2D.curve.set_point_out($Path2D.curve.point_count - 1, next_path.get_point_out(0))
	
	for i in range(1,next_path.point_count):
		$Path2D.curve.add_point(
			next_path.get_point_position(i),
			next_path.get_point_in(i),
			next_path.get_point_out(i)
		)
	
	current_segment = next_segment

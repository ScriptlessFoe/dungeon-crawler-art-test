extends Control
class_name DamageNumberComponent
# a simple damange number component using default labels

@export var fontSize:int = 7
@export var fontColor:Color = Color.RED
@export var fontOutlineColor:Color = Color.PINK
@export var outlineSize:int = 2
@export var randRadius:float = 5.0

var exitingTree:bool = false
signal labelsFinished

func make_damage_number(value:int) -> void:
	var label:Label = _create_label()
	add_child(label)
	label.text = str(value)
	await _animate_label(label)
	label.queue_free()
	
	check_labels()

# allow remaining labels to finish processing after death
func check_labels() -> void:
	if exitingTree:
		await get_tree().process_frame
		if get_child_count() == 0:
			labelsFinished.emit()

func _create_label() -> Label:
	var label:Label = Label.new()
	label.add_theme_font_size_override("font_size", fontSize)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_color_override("font_color", fontColor)
	label.add_theme_color_override("font_outline_color", fontOutlineColor)
	label.add_theme_constant_override("outline_size", outlineSize)
	return label

func _animate_label(label:Label) -> void:
	label.position = Vector2(randf_range(-randRadius, randRadius), randf_range(-randRadius, randRadius))
	
	var tween:Tween = create_tween().set_parallel(true)
	tween.tween_property(label, "position:y", label.position.y - 25, 0.25)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_property(label, "position:y", label.position.y, 0.25)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_IN)\
		.set_delay(0.25)
	tween.tween_property(label, "scale", Vector2.ZERO, 0.25)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_IN)\
		.set_delay(0.5)
	
	await tween.finished

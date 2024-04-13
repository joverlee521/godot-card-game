extends Area2D

signal card_clicked(card_selected: bool)

@export var back_image: CompressedTexture2D


const expected_card_suits = ['clubs', 'diamonds', 'hearts', 'spades']
const card_values = {
	'02' = 2,
	'03' = 3,
	'04' = 4,
	'05' = 5,
	'06' = 6,
	'07' = 7,
	'08' = 8,
	'09' = 9,
	'10' = 10,
	'jack' = 10,
	'queen' = 10,
	'king' = 10,
	'ace' = 11
}

var card_suit: String
var card_name: String
var card_value: int

var mouse_entered_card: bool = false
var card_selected: bool = false
var prevent_selection: bool = false


func _ready():
	$Sprite2D.texture = back_image


func setup(new_suit, new_name, new_back_image = back_image):
	card_suit = new_suit
	card_name = new_name
	back_image = new_back_image

	assert(card_suit in expected_card_suits, 'Card suit must be one of %s' % ','.join(expected_card_suits))
	assert(card_name in card_values, 'Card names must be one of %s' % ','.join(card_values.keys()))

	card_value = card_values[card_name]
	$Sprite2D.texture = back_image


func reveal_card():
	show()

	var image_file = "res://art/Cards/{suit}_{name}.png".format({ 'suit': card_suit, 'name': card_name })
	$Sprite2D.texture = load(image_file)


# Custom handler for input to work around overlapping Area2D objects both getting input
# See https://github.com/godotengine/godot/issues/29825
# Resolved in https://github.com/godotengine/godot/pull/75688
# which was released in Godot v4.3
func _unhandled_input(event):
	if (event.is_action_pressed("mouse_left_click")
	and mouse_entered_card):
		if !prevent_selection or card_selected:
			card_selected = !card_selected

			if card_selected:
				position.y = position.y - 50
			else:
				position.y = position.y + 50

			emit_signal("card_clicked", card_selected)

		self.get_viewport().set_input_as_handled()

func _on_Area2D_mouse_entered():
	mouse_entered_card = true

func _on_Area2D_mouse_exited():
	mouse_entered_card = false

func _on_cards_selected(max_cards_selected):
	prevent_selection = max_cards_selected

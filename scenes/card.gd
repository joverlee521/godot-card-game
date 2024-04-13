extends Area2D

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
var card_selected: bool = false


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


func _on_input_event(viewport, event, shape_idx):
	if (event.is_pressed()
		and event.button_index == MOUSE_BUTTON_LEFT):

		card_selected = !card_selected

		if card_selected:
			position.y = position.y - 50
		else:
			position.y = position.y + 50

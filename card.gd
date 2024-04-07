extends Sprite2D


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

var back_image = "res://art/Cards/back03.png"
var card_suit: String
var card_name: String
var card_value: int


func _ready():
	texture = load(back_image)
	hide()


func setup(new_suit, new_name):
	card_suit = new_suit
	card_name = new_name

	assert(card_suit in expected_card_suits, 'Card suit must be one of %s' % ','.join(expected_card_suits))
	assert(card_name in card_values, 'Card names must be one of %s' % ','.join(card_values.keys()))

	card_value = card_values[card_name]


func reveal_card():
	show()

	var image_file = "res://art/Cards/{suit}_{name}.png".format({ 'suit': card_suit, 'name': card_name })
	texture = load(image_file)


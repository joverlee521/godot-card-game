extends TextureButton


@export var card_scene: PackedScene


# Default normal deck
var card_suits = ['clubs', 'diamonds', 'hearts', 'spades']
var card_names = ['02', '03', '04', '05', '06', '07', '08', '09', '10', 'jack', 'queen', 'king', 'ace']
var remaining_cards = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for card_suit in card_suits:
		for card_name in card_names:
			var card = { "suit": card_suit, "name": card_name }
			remaining_cards.append(card)

	remaining_cards.shuffle()

	var default_card = card_scene.instantiate()
	default_card.name = 'DefaultCard'
	add_child(default_card)

	$DefaultCard.position = $DefaultCardPosition.position
	$DefaultCard.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if remaining_cards.size() == 0:
		$DefaultCard.hide()
		disabled = true


func get_card():
	var card_details = remaining_cards.pop_front()
	var new_card = card_scene.instantiate()
	new_card.setup(card_details['suit'], card_details['name'])

	add_child(new_card)
	new_card.reveal_card()


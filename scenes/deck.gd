extends Node2D

signal dealt_card(new_card)
signal empty_deck


@export var card_scene: PackedScene
@export var deck_image: CompressedTexture2D


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
	$Sprite2D.texture = deck_image


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if remaining_cards.size() == 0:
		$Sprite2D.hide()
		empty_deck.emit()


func get_card():
	if remaining_cards.size() == 0:
		return

	var card_details = remaining_cards.pop_front()
	var new_card = card_scene.instantiate()
	new_card.setup(card_details['suit'], card_details['name'], deck_image)
	emit_signal("dealt_card", new_card)


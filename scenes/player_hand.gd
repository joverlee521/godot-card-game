extends ColorRect

signal hand_full

var hand_size: int = 5:
	set(value):
		hand_size = value
		set_card_x_spacing()

var card_y
var card_x_spacing
var cards_in_hand = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var rect = get_rect()
	var position = rect.position
	var size = rect.size

	card_y = size.y/2
	set_card_x_spacing()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_card_x_spacing():
	card_x_spacing = size.x/(hand_size + 1)


func _on_deck_dealt_card(new_card):
	if cards_in_hand.size() >= hand_size:
		print("MAX HAND SIZE")
		return

	cards_in_hand.append({
		'card_name': new_card.card_name,
		'card_suit': new_card.card_suit,
	})

	add_child(new_card)
	#new_card.set_owner(self)

	var card_x = cards_in_hand.size() * card_x_spacing
	new_card.position = Vector2(card_x, card_y)
	new_card.reveal_card()

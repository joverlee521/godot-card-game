extends ColorRect

signal hand_full

var hand_size: int = 5:
	set(value):
		hand_size = value
		set_card_x_spacing()

var card_y
var card_x_spacing
var cards_in_hand = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Ignore mouse events here so the individual cards can be clicked
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_y = get_rect().size.y/2
	set_card_x_spacing()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_card_x_spacing():
	card_x_spacing = size.x/(hand_size + 1)


func _on_deck_dealt_card(new_card):
	if cards_in_hand >= hand_size:
		print("MAX HAND SIZE")
		return

	add_child(new_card)
	cards_in_hand += 1

	var card_x = cards_in_hand * card_x_spacing
	new_card.position = Vector2(card_x, card_y)
	new_card.reveal_card()


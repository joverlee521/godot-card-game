extends ColorRect

signal hand_full
signal cards_selected(max_cards_selected: bool)
signal cards_played(cards)

const max_selected = 5

var hand_size: int = 5:
	set(value):
		hand_size = value
		set_card_x_spacing()

var card_y
var card_x_spacing
var cards_in_hand = 0
var current_selected = 0

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


func position_card(card, card_order):
	var card_x = card_order * card_x_spacing
	card.position = Vector2(card_x, card_y)


func _on_deck_dealt_card(new_card):
	if cards_in_hand >= hand_size:
		print("MAX HAND SIZE")
		return

	add_child(new_card)
	new_card.add_to_group("cards_in_hand")

	# 2-way signal connection to prevent selecting more cards than the max_selected
	new_card.card_clicked.connect(_on_card_clicked)
	self.cards_selected.connect(new_card._on_cards_selected)

	cards_in_hand += 1
	position_card(new_card, cards_in_hand)
	new_card.reveal_card()


func _on_card_clicked(card_selected, card):
	if card_selected:
		current_selected += 1
		card.add_to_group("selected_cards")
	else:
		current_selected -= 1
		card.remove_from_group("selected_cards")

	emit_signal("cards_selected", current_selected == max_selected)


func _on_play_cards():
	var selected_cards = get_tree().get_nodes_in_group("selected_cards")

	var num_selected_cards = len(selected_cards)
	cards_in_hand -= num_selected_cards
	current_selected = 0

	for card in selected_cards:
		card.remove_from_group("selected_cards")
		card.remove_from_group("cards_in_hand")
		remove_child(card)

	var remaining_cards = get_tree().get_nodes_in_group("cards_in_hand")
	for i in len(remaining_cards):
		var card = remaining_cards[i]
		position_card(card, i+1)

	emit_signal("cards_played", selected_cards)
	emit_signal("cards_selected", current_selected == max_selected)

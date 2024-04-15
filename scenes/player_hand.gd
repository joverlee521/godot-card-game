extends ColorRect

signal hand_full
signal cards_selected(max_cards_selected: bool)
signal cards_played(cards)

const max_selected = 5

var hand = Hand.new()
var hand_size: int:
	set(value):
		hand.max_hand_size = value
		set_card_x_spacing()


var card_y
var card_x_spacing

var sort_attribute = "card_name":
	set(value):
		sort_attribute = value
		position_all_cards()


# Called when the node enters the scene tree for the first time.
func _ready():
	# Ignore mouse events here so the individual cards can be clicked
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_y = get_rect().size.y/2
	set_card_x_spacing()


func set_card_x_spacing():
	card_x_spacing = size.x/(hand.max_hand_size + 1)


func position_card(card, card_order):
	var card_x = card_order * card_x_spacing
	card.position = Vector2(card_x, card_y)
	card.z_index = card_order


func position_all_cards():
	hand.sort_cards(sort_attribute)
	for i in hand.size():
		var card = hand.cards[i]
		position_card(card, i+1)


func _on_deck_dealt_card(new_card):
	hand.add_card(new_card)
	add_child(new_card)

	# 2-way signal connection to prevent selecting more cards than the max_selected
	new_card.card_clicked.connect(_on_card_clicked)
	self.cards_selected.connect(new_card._on_cards_selected)

	position_all_cards()
	new_card.reveal_card()


func _on_sort_by_name():
	sort_attribute = "card_name"


func _on_sort_by_suit():
	sort_attribute = "card_suit"


func _on_card_clicked():
	emit_signal("cards_selected", len(hand.selected_cards()) == max_selected)


func _on_play_cards():
	var selected_cards = hand.selected_cards()
	for card in selected_cards:
		hand.remove_card(card)
		remove_child(card)

	position_all_cards()

	emit_signal("cards_played", selected_cards)
	emit_signal("cards_selected", len(hand.selected_cards()) == max_selected)

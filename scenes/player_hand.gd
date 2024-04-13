extends ColorRect

signal hand_full
signal cards_selected(max_cards_selected: bool)

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


func _on_deck_dealt_card(new_card):
	if cards_in_hand >= hand_size:
		print("MAX HAND SIZE")
		return

	add_child(new_card)

	# 2-way signal connection to prevent selecting more cards than the max_selected
	new_card.card_clicked.connect(_on_card_clicked)
	self.cards_selected.connect(new_card._on_cards_selected)

	cards_in_hand += 1
	var card_x = cards_in_hand * card_x_spacing
	new_card.position = Vector2(card_x, card_y)
	new_card.reveal_card()


func _on_card_clicked(card_selected):
	if card_selected:
		current_selected += 1
	else:
		current_selected -= 1

	emit_signal("cards_selected", current_selected == max_selected)

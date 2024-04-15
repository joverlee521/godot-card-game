class_name Hand


var max_hand_size: int
var cards: Array
var card_groups: Dictionary


func _init(cards = [], max_hand_size = 5):
	self.max_hand_size = max_hand_size
	cards.map(add_card)


func add_card(card):
	assert(size() < max_hand_size, "Reached max_hand_size %s" % max_hand_size)
	cards.append(card)


func remove_card(card):
	cards.erase(card)


func clear():
	cards.clear()


func size():
	return len(cards)


func selected_cards():
	return cards.filter(func(card): return card.card_selected)


func group_cards(card_attribute = "card_name"):
	for card in cards:
		var attribute = card[card_attribute]
		var attribute_group = card_groups.get(attribute, [])
		attribute_group.append(card)
		card_groups[attribute] = attribute_group


func sort_cards(attribute: String) -> void:
	var inner_attribute = ""
	if attribute == "card_name":
		inner_attribute = "card_suit"
	elif attribute == "card_suit":
		inner_attribute = "card_name"
	else:
		assert(false, "Unexpected attribute for sorting: %s" % attribute)

	sort_by_attribute(inner_attribute)
	sort_by_attribute(attribute)


# Sorts in ascending order of card_name based on the order in Card.card_values
func sort_by_attribute(attribute) -> void:
	var sort_order = []
	if attribute == "card_name":
		sort_order = Card.card_values.keys()
	elif attribute == "card_suit":
		sort_order = Card.expected_card_suits
	else:
		assert(false, "Unexpected attribute for sorting: %s" % attribute)

	cards.sort_custom(
		func(card_a, card_b):
			return sort_order.find(card_a[attribute]) < sort_order.find(card_b[attribute])
	)

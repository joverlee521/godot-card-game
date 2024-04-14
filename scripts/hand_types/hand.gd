class_name Hand


var max_hand_size: int
var cards: Array
var card_groups: Dictionary


func _init(cards = [], max_hand_size = 5):
	self.max_hand_size = max_hand_size
	cards.map(add_card)


func add_card(card):
	assert(len(cards) < max_hand_size, "Reached max_hand_size %s" % max_hand_size)
	cards.append(card)


func group_cards(card_attribute = "card_name"):
	for card in cards:
		var attribute = card[card_attribute]
		var attribute_group = card_groups.get(attribute, [])
		attribute_group.append(card)
		card_groups[attribute] = attribute_group

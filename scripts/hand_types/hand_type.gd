class_name HandType

var name: String
var base_score: int
var card_groups: Dictionary = {}


func _init():
	pass


func verify_hand(cards: Array) -> Array:
	assert(false, "verify_hand method must be implemented by subclasses")
	return []


func group_cards(cards, card_attribute = "card_name"):
	for card in cards:
		var attribute = card[card_attribute]
		var attribute_group = card_groups.get(attribute, [])
		attribute_group.append(card)
		card_groups[attribute] = attribute_group

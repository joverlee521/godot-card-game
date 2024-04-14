class_name ThreeOfAKind extends HandType


func _init():
	super()
	name = 'three of a kind'
	base_score = 4


func verify_hand(cards):
	group_cards(cards,"card_name")

	for card_name in card_groups:
		if len(card_groups[card_name]) == 3:
			return card_groups[card_name]

	return []

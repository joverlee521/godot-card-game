class_name FourOfAKind extends HandType


func _init():
	super()
	name = 'four of a kind'
	base_score = 8


func verify_hand(cards):
	group_cards(cards,"card_name")

	for card_name in card_groups:
		if len(card_groups[card_name]) == 4:
			return card_groups[card_name]

	return []

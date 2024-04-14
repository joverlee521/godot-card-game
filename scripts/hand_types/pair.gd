class_name Pair extends HandType


func _init():
	super()
	name = "pair"
	base_score = 2


func verify_hand(cards):
	group_cards(cards,"card_name")

	for card_name in card_groups:
		if len(card_groups[card_name]) == 2:
			return card_groups[card_name]

	return []

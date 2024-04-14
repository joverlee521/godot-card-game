class_name Flush extends HandType


func _init():
	super()
	name = 'flush'
	base_score = 6


func verify_hand(cards):
	group_cards(cards,"card_suit")

	for card_name in card_groups:
		if len(card_groups[card_name]) == 5:
			return card_groups[card_name]

	return []

class_name Flush extends HandType


func _init(cards):
	super(cards)
	name = 'flush'
	base_score = 6


func verify_hand():
	group_cards("card_suit")

	for card_name in card_groups:
		if len(card_groups[card_name]) == 5:
			return card_groups[card_name]

	return []

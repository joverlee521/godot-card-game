class_name Pair extends HandType


func _init(cards):
	super(cards)
	name = "pair"
	base_score = 2
	min_cards = 2


func verify_hand():
	if super().is_empty(): return []

	group_cards("card_name")

	for card_name in card_groups:
		if len(card_groups[card_name]) == 2:
			return card_groups[card_name]

	return []

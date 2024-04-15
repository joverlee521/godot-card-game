class_name ThreeOfAKind extends HandType


func _init(cards):
	super(cards)
	name = 'three of a kind'
	base_score = 4
	min_cards = 3


func verify_hand():
	if super().is_empty(): return []

	group_cards("card_name")

	for card_name in card_groups:
		if len(card_groups[card_name]) == 3:
			return card_groups[card_name]

	return []

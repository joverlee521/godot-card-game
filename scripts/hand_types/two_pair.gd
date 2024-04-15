class_name TwoPair extends HandType


func _init(cards):
	super(cards)
	name = "two pair"
	base_score = 3
	min_cards = 4


func verify_hand():
	if super().is_empty(): return []

	var verified_cards = []
	group_cards("card_name")

	for card_name in card_groups:
		if len(card_groups[card_name]) == 2:
			verified_cards.append_array(card_groups[card_name])

		if len(verified_cards) == 4:
			return verified_cards

	return []

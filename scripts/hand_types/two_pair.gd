class_name TwoPair extends HandType


func _init():
	super()
	name = "two pair"
	base_score = 3


func verify_hand(cards):
	var verified_cards = []
	group_cards(cards,"card_name")

	for card_name in card_groups:
		if len(card_groups[card_name]) == 2:
			verified_cards.append_array(card_groups[card_name])

		if len(verified_cards) == 4:
			return verified_cards

	return []

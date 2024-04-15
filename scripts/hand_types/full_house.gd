class_name FullHouse extends HandType


func _init(cards):
	super(cards)
	name = "full house"
	base_score = 7
	min_cards = 5


func verify_hand():
	if super().is_empty(): return []

	var pair = []
	var three_of_a_kind = []
	group_cards("card_name")

	for card_name in card_groups:
		if len(card_groups[card_name]) == 2:
			pair = card_groups[card_name]

		if len(card_groups[card_name]) == 3:
			three_of_a_kind = card_groups[card_name]

	if !pair.is_empty() and !three_of_a_kind.is_empty():
		return pair + three_of_a_kind

	return []

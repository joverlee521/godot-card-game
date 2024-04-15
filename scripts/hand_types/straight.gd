class_name Straight extends HandType


func _init(cards):
	super(cards)
	name = "straight"
	base_score = 4
	min_cards = 5


func verify_hand():
	if super().is_empty(): return []

	var verified_cards = verify_straight()

	# Do a second check for straights if Ace is in hand
	# Reorders with ace in the front to allow for lower straights
	if (verified_cards.is_empty()
		and cards.any(func(card): return card.card_name == "ace")):

		card_name_order.erase("ace")
		card_name_order.push_front("ace")
		verified_cards = verify_straight()

	return verified_cards


func verify_straight():
	sort_by_attribute("card_name")

	var previous_index = null

	for card in cards:
		var current_index = card_name_order.find(card.card_name)

		# Check if the previous index is one less than current index
		if (previous_index != null
		and (previous_index + 1) != current_index):
			return []

		previous_index = current_index

	return cards

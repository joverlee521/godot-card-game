class_name Flush extends HandType


func _init(cards):
	super(cards)
	name = 'flush'
	base_score = 6
	min_cards = 5


func verify_hand():
	if super().is_empty(): return []

	var first_suit = cards[0].card_suit

	if cards.any(func(card): return card.card_suit != first_suit):
		return []

	return cards

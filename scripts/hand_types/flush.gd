class_name Flush extends HandType


func _init(cards):
	super(cards)
	name = 'flush'
	base_score = 6


func verify_hand():
	var first_suit = cards[0].card_suit

	if cards.any(func(card): return card.card_suit != first_suit):
		return []

	return cards

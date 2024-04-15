class_name StraightFlush extends Straight


func _init(cards):
	super(cards)
	name = "straight flush"
	base_score = 8


func verify_hand():
	var verified_straight = super()

	if verified_straight.is_empty():
		return []
	else:
		var first_suit = cards[0].card_suit
		if cards.any(func(card): return card.card_suit != first_suit):
			return []
		return cards

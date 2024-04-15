class_name HighCard extends HandType


func _init(cards):
	super(cards)
	name = "high card"
	base_score = 1


func verify_hand():
	if super().is_empty(): return []

	sort_by_attribute("card_name")
	cards.reverse()
	return [cards[0]]


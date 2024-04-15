class_name HandType extends Hand

var name: String
var base_score: int
var min_cards: int = 1


func _init(cards):
	super(cards)


func verify_hand() -> Array:
	if self.size() >= min_cards:
		return cards

	return []

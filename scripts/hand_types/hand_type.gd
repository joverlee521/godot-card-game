class_name HandType extends Hand

var name: String
var base_score: int


func _init(cards):
	super(cards)


func verify_hand() -> Array:
	assert(false, "verify_hand method must be implemented by subclasses")
	return []

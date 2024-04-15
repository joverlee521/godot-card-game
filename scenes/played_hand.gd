extends Node2D


signal hand_played(hand_score: int)


var hand_types = [
	StraightFlush,
	FourOfAKind,
	FullHouse,
	Flush,
	Straight,
	ThreeOfAKind,
	TwoPair,
	Pair,
	HighCard,
]

var hand_score = 0


func _ready():
	$PlayedHandName.text = ""


func add_played_cards(cards):
	for i in len(cards):
		var card = cards[i]
		card.add_to_group("played_cards")
		add_child(card)
		card.card_played = true
		card.position = get_node('PlayedCard%s' % i).position


	for hand_type in hand_types:
		var hand = hand_type.new(cards)
		var verified_cards = hand.verify_hand()
		if !verified_cards.is_empty():
			$PlayedHandName.text = hand.name.to_upper()
			verified_cards.map(func(card): card.position.y -= 50)
			calculate_hand_score(verified_cards, hand.base_score)
			$PlayedHandScore.text = str(hand_score)
			break

	await get_tree().create_timer(2.0).timeout

	$PlayedHandName.text = ""
	$PlayedHandScore.text = ""
	get_tree().call_group("played_cards", "queue_free")
	emit_signal("hand_played", hand_score)


func calculate_hand_score(cards, score_multiplier):
	var sum = cards.reduce(func(accum, card): return accum + card.card_value, 0)
	hand_score = sum * score_multiplier


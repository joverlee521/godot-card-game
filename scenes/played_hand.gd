extends Node2D

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
			# TODO: Calculate played cards values here
			verified_cards.map(func(card): card.position.y -= 50)
			break

	await get_tree().create_timer(2.0).timeout

	$PlayedHandName.text = ""
	get_tree().call_group("played_cards", "queue_free")

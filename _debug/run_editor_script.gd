@tool
extends EditorScript

func _run():
	var instance = TwoPair.new()

	var cards = [
		{'card_name': '02', 'card_suit': 'spades'},
		{'card_name': '02', 'card_suit': 'diamonds'},
		{'card_name': '03', 'card_suit': 'spades'},
		{'card_name': '03', 'card_suit': 'hearts'}
	]

	print(instance.verify_hand(cards))

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_played_cards(cards):
	for i in len(cards):
		var card = cards[i]
		card.add_to_group("played_cards")
		add_child(card)
		card.card_played = true
		card.position = get_node('PlayedCard%s' % i).position

	# TODO: Calculate played cards values here
	await get_tree().create_timer(1.0).timeout

	get_tree().call_group("played_cards", "queue_free")

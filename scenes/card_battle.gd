extends Node

var battle_hand_size = 8
var total_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$TotalScore.text = str(total_score)
	$PlayerHand.hand_size = battle_hand_size
	await get_tree().create_timer(2.0).timeout
	deal_hand()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func deal_hand():
	deal_cards(battle_hand_size)


func deal_cards(number_of_cards):
	for n in number_of_cards:
		await get_tree().create_timer(0.2).timeout
		$Deck.get_card()


func _on_cards_played(cards):
	var num_cards_played = len(cards)
	await $PlayedHand.add_played_cards(cards)

	deal_cards(num_cards_played)


func _on_hand_played(hand_score):
	total_score += hand_score
	$TotalScore.text = str(total_score)

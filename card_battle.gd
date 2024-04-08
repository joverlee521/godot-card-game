extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_deck_dealt_card(new_card):
	add_child(new_card)
	new_card.position = $CardPosition.position
	new_card.reveal_card()

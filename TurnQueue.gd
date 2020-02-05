extends Node2D

class_name TurnQueue

var active_combatant : Player

signal queue_changed

func initialize():
	var combatants = get_combatants()
	combatants.sort_custom(self, 'sort_combatants')
	active_combatant = get_child(0)
	for Player in combatants:
		Player.raise()
	active_combatant = get_child(0)
#	emit_signal('queue_changed', get_combatants(), active_combatant)
	
func play_turn():
	yield(active_combatant.play_turn(), "completed")
	var new_index : int = active_combatant.get_index() + 1 % get_child_count()
	active_combatant = get_child(new_index)
	
static func sort_combatants(a : Player, b : Player) -> bool:
	return a.Speed > b.Speed
	
	
func get_combatants():
	return get_children()

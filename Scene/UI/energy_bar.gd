extends VBoxContainer

var energy : PackedScene = preload("res://Scene/UI/energy.tscn")

func _ready() -> void:
	InventorySystem.State_change.connect(add_energy)
	for child in get_children():
		child.queue_free()
	
	var amount : int = InventorySystem.spring_total_energy / 20
	
	for i in range(amount):
		add_energy(null)

func add_energy(type) -> void:
	for child in get_children():
		child.queue_free()
	
	var amount : int = InventorySystem.spring_total_energy / 20
	
	for i in range(amount):
		var energy_ins = energy.instantiate()
		add_child(energy_ins)

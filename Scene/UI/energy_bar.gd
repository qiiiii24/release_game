extends VBoxContainer

var energy : PackedScene = preload("res://Scene/UI/energy.tscn")

var max_amount : int = InventorySystem.spring_total_energy / 20

func _ready() -> void:
	Event.change_energy_bar.connect(change_energy_ui)
	Event.ability_change.connect(add_energy)
	for child in get_children():
		child.queue_free()
	
	max_amount = InventorySystem.spring_total_energy / 20
	for i in range(max_amount):
		add_energy(null)

func add_energy(_type) -> void:
	for child in get_children():
		child.queue_free()
	
	max_amount = InventorySystem.spring_total_energy / 20
	InventorySystem.energy = InventorySystem.spring_total_energy
	var amount : int = max_amount
	
	for i in range(amount):
		var energy_ins = energy.instantiate()
		add_child(energy_ins)

func change_energy_ui() -> void:
	var energys := get_children() # energy数组
	#var max_energy = InventorySystem.spring_total_energy / 20 #满energy是多少颗
	var amount = InventorySystem.energy / 10 #当前有多少（半颗）
	
	var full_energy = amount / 2 # 当前有多少颗满的能量
	
	for i in range(full_energy):
		#print("full_energy = %s" % full_energy)
		energys[i].update(2)
	
	if full_energy == energys.size(): 
		return
	
	var remainder = amount % 2 #是否剩下半颗能量，如果剩下应该为1，不剩下则为0
	#print("amount = %s" % amount)
	#print("remainder =  %s" % remainder)
	energys[full_energy].update(remainder)
	
	for i in range(full_energy + 1, energys.size()):
		energys[i].update(0)
		

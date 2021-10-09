extends Spatial

signal dead
signal hurt
signal healed
signal health_changed
signal gibbed

export var max_health = 100
var cur_health = 1

export var gib_at = -20

func _ready():
	init()

func init():
	cur_health = max_health
	emit_signal("health_changed",cur_health)

func hurt(damage : int, dir : Vector3, damage_type="normal"):
	if cur_health <= 0:
		return
	cur_health -= damage
	if cur_health <= gib_at:
		pass #todo gib spawner
		emit_signal("gibbed")
	if cur_health <= 0:
		emit_signal("dead")
		print('dead')
	else:
		emit_signal("hurt")
		print('hurt',damage,'health',cur_health)
	emit_signal("health_changed", cur_health)
	
func heal (amount : int):
	if cur_health <= 0:
		pass
	cur_health +=amount
	if cur_health > max_health:
		cur_health = max_health
	emit_signal("healed")
	print('healed',amount,'health',cur_health)
	emit_signal("health_changed",cur_health)

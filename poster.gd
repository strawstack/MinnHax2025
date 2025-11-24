extends Sprite3D

var viewport

func _ready():
	viewport = $SubViewport
	$SubViewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)
	texture = viewport.get_texture()

func _process(delta):
	pass

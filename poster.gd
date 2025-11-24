extends Sprite3D

var viewport

func _ready():
	viewport = $SubViewport
	$SubViewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)

func _process(_delta):
	texture = viewport.get_texture()

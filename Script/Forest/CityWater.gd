extends Sprite2D

func _ready():
	# получить материал, связанный с этой нодой
	var material = self.material

	# проверить, что материал не пустой, чтобы избежать ошибки
	if material != null:
		_zoom(material)

func _zoom(material):
	# установить значение глобального параметра шейдера
	material.global_shader_parameter_set("zoom_y", get_viewport_transform().get_scale().y)


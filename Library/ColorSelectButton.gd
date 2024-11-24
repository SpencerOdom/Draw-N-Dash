@tool
extends TextureButton
class_name ColorSelectButton


@export var alpha_border: int = 16:
	set(val):
		alpha_border = val
		set_textures()

@export var icon: CompressedTexture2D:
	set(val):
		icon = val
		set_textures()


var see_through = Color(1.0, 1.0, 1.0, 0.0)


func set_textures():
	if not icon:
		return
	if alpha_border < 0:
		return
	
	var __icon: ImageTexture = ImageTexture.create_from_image(icon.get_image())
	
	# button texture_normal (larger version of regular icon, but with alpha border)
	var raw_icon_image: Image = __icon.get_image()
	var raw_icon_size: Vector2i = raw_icon_image.get_size()
	var icon_normal: Image = Image.create(
		raw_icon_size.x + int(alpha_border)*2,
		raw_icon_size.y + int(alpha_border)*2,
		false,
		Image.FORMAT_RGBA8,
	)
	for x in icon_normal.get_size().x:
		for y in icon_normal.get_size().y:
			# if we're out of the bounds of the smaller raw icon, then set a see-through pixel
			# (as we're surrounding the original 128x128 icon with a 16px see-through
			# border on all sides, making the new icon 160x160)
			var is_on_border_x = x < alpha_border or x >= icon_normal.get_size().x - alpha_border
			var is_on_border_y = y < alpha_border or y >= icon_normal.get_size().y - alpha_border
			if is_on_border_x or is_on_border_y:
				icon_normal.set_pixel(x, y, see_through)
			else:
				# otherwise, copy the smaller icon into the middle of the new larger icon
				var pixel: Color = raw_icon_image.get_pixel(x-int(alpha_border), y-int(alpha_border))
				icon_normal.set_pixel(x, y, pixel)
	
	texture_normal = ImageTexture.create_from_image(icon_normal)
	
	# button texture_hover: inverted icon
	var icon_hover: Image = icon_normal.duplicate()
	for x in icon_hover.get_size().x:
		for y in icon_hover.get_size().y:
			var pixel: Color = icon_hover.get_pixel(x, y)
			icon_hover.set_pixel(x, y, pixel.lightened(0.25))
	texture_hover = ImageTexture.create_from_image(icon_hover)
	
	# button texture_pressed: lighter inverted icon
	var icon_pressed: Image = icon_hover.duplicate()
	for x in icon_pressed.get_size().x:
		for y in icon_pressed.get_size().y:
			var pixel: Color = icon_pressed.get_pixel(x, y)
			icon_pressed.set_pixel(x, y, pixel.lightened(0.7))
	texture_pressed = ImageTexture.create_from_image(icon_pressed)
	
	# button texture_focused: just border, clear alpha in middle
	var icon_focused: Image = icon_normal.duplicate()
	for x in icon_focused.get_size().x:
		for y in icon_focused.get_size().y:
			# the alpha border on textuer_normal is 'alpha_border' wide, but the
			# white rectangle is half that
			var is_on_border_x = x < alpha_border/2.0 or x >= icon_focused.get_size().x - alpha_border/2.0
			var is_on_border_y = y < alpha_border/2.0 or y >= icon_focused.get_size().y - alpha_border/2.0
			if is_on_border_x or is_on_border_y:
				icon_focused.set_pixel(x, y, Color.WHITE)
			else:
				# otherwise, make it see-through
				icon_focused.set_pixel(x, y, see_through)
	texture_focused = ImageTexture.create_from_image(icon_focused)
	
	# button texture_disabled: gray icon
	var _texture_disabled: Texture = ImageTexture.create_from_image(icon_normal)
	texture_disabled = to_grayscale(_texture_disabled)
	
#	var icon_disabled: Image = _texture_disabled.get_image()
#	print("(QuickTextureButton) icon=%s, normal=%s, hover=%s, pressed=%s, focused=%s, disabled=%s" % [
#		icon.get_size(), icon_normal.get_size(), icon_hover.get_size(),
#		icon_pressed.get_size(), icon_focused.get_size(), icon_disabled.get_size(),
#	])


func to_grayscale(texture: ImageTexture) -> Texture:
	var image = texture.get_image()
	image.convert(Image.FORMAT_LA8)
	image.convert(Image.FORMAT_RGBA8) # Not strictly necessary
	return ImageTexture.create_from_image(image)


func _on_pressed() -> void:
	pass # Replace with function body.


func _on_eraser_button_pressed() -> void:
	pass # Replace with function body.

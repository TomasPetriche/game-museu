extends Popup
class_name ArtefactPopup

export (NodePath) var nameLabel : NodePath
export (NodePath) var textLabel : NodePath
export (NodePath) var iconTexture : NodePath


func _popup_pick_up(name: String, fill_text: String, icon_texture : Texture):
	if nameLabel:
		(get_node(nameLabel) as Label).text = "Você encontrou %s!" % [name]
	if textLabel:
		(get_node(textLabel) as Label).text = fill_text
	if iconTexture:
		(get_node(iconTexture) as TextureRect).texture = icon_texture
	self.popup()
	pass

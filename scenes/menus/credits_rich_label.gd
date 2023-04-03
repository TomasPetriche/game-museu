extends RichTextLabel


func _ready():
	var _err = connect("meta_clicked",self,"meta_clicked")
	pass

func meta_clicked(meta):
	var _err = OS.shell_open(str(meta))

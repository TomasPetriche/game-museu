extends Node2D

# Paths
export (NodePath) var next_button_path : NodePath = ""
export (NodePath) var back_button_path : NodePath = ""
export (NodePath) var dialog_label_path : NodePath = ""
export (NodePath) var name_label_path : NodePath = ""


# Nodes
onready var next_button : Button = get_node_or_null(next_button_path)
onready var back_button: Button = get_node_or_null(back_button_path)
onready var dialog_label : Label = get_node_or_null(dialog_label_path)
onready var name_label : Label = get_node_or_null(name_label_path)



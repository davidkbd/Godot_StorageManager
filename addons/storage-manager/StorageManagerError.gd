extends CanvasLayer

onready var background  : TextureRect = $Background
onready var alpha_layer : ColorRect   = $ColorRect
onready var message     : Label       = $Message
onready var err_name    : Label       = $ErrName
onready var exit_button : Button      = $Button
onready var link_button : Button      = $Button2

var text              : String
var cause             : String
var link              : String
var link_text         : String
var bg_texture        : Texture
var alpha_layer_color : Color
var text_color        : Color

func _on_Button_pressed():
	get_tree().quit()

func _ready():
	background.texture = bg_texture
	alpha_layer.color = alpha_layer_color
	if not bg_texture:
		alpha_layer.color.a = 1.0
	message.set("custom_colors/font_color", text_color)
	message.text = text
	err_name.text = "Cause: " + cause
	exit_button.grab_focus()
	if link == "" or link == "https://":
		link_button.hide()
	else:
		link_button.show()
	if link_text == "":
		link_button.text = "Report"
	else:
		link_button.text = link_text
	print("ERROR: ", text, " - ", cause)
	get_tree().paused = true

func _on_Button2_pressed():
	OS.shell_open(link)

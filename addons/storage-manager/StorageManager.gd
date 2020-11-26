extends Node

class_name StorageManager

export(String) var file_name : String = "user://my_file.json"
export(String) var password  : String = ""
export(bool)   var blocker   : bool   = true

export(Texture) var error_bg_texture : Texture
export(Color)   var error_alpha_layer_color : Color = Color(0,0,0,.5)
export(Color)   var error_text_color : Color = Color.red
export(String)  var link             : String = "https://"
export(String)  var link_text        : String = "Please, send me a screenshot with this error"

func load_json() -> Dictionary:
	var storage = Storage.new(file_name, password)
	var r = storage.load_json()
	if r.result == OK: return r
	if blocker: _show_load_error(r)
	return r

func load_text() -> Dictionary:
	var storage = Storage.new(file_name, password)
	var r = storage.load_text()
	if r.result == OK: return r
	if blocker: _show_load_error(r)
	return r

func load_data() -> Dictionary:
	var storage = Storage.new(file_name, password)
	var r = storage.load_data()
	if r.result == OK: return r
	if blocker: _show_load_error(r)
	return r

func store_json(data : Dictionary) -> Dictionary:
	var storage = Storage.new(file_name, password)
	var r = storage.store_json(data)
	if r.result == OK: return r
	if blocker: _show_store_error(r)
	return r

func store_text(data : String) -> Dictionary:
	var storage = Storage.new(file_name, password)
	var r = storage.store_text(data)
	if r.result == OK: return r
	if blocker: _show_store_error(r)
	return r

func store_data(data : Dictionary) -> Dictionary:
	var storage = Storage.new(file_name, password)
	var r = storage.store_data(data)
	if r.result == OK: return r
	if blocker: _show_store_error(r)
	return r

func _show_load_error(json : Dictionary):
	var err = load("res://addons/storage-manager/StorageManagerError.res").instance()
	err.bg_texture = error_bg_texture
	err.alpha_layer_color = error_alpha_layer_color
	err.text_color = error_text_color
	err.text = "An error has occurred loading " + json.file
	err.link = link
	err.link_text = link_text
	err.cause = json.error
	add_child(err)

func _show_store_error(json : Dictionary):
	var err = load("res://addons/storage-manager/StorageManagerError.res").instance()
	err.bg_texture = error_bg_texture
	err.alpha_layer_color = error_alpha_layer_color
	err.text_color = error_text_color
	err.text = "An error has occurred writting " + json.file
	err.link = link
	err.link_text = link_text
	err.cause = json.error
	add_child(err)

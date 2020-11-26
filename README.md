# Godot_StorageManager
### Utility to facilitate file loading and writing management
Here is a class called Storage that allows loading and saving json files, text-plain and data.

But you can add the StorageManager in your scene to access to that class.
You can turn TRUE the "blocker" property in this Node to specify that in case of error a message should be displayed and the game ended.

### Example code (Load Encrypted Data)

var storage : Storage = Storage.new("user://settings.data", "ENCRYPT_PASSWORD")
var data = storage.load_data()
if data.result == OK:
	AudioServer.set_bus_volume_db(0, linear2db(data.data.volume))
	OS.vsync_enabled = data.data.vsync
else:
	AudioServer.set_bus_volume_db(0, linear2db(.8))
	OS.vsync_enabled = true

### Example code (Store Encrypted Data)

var storage : Storage = Storage.new("user://settings.data", "ENCRYPT_PASSWORD")
var result = storage.store_data({ "xxx": "yyy" })
if result != OK: print("Error")

### Example code (Load JSON)

var storage : Storage = Storage.new("res://file.json")
var data = storage.load_json()
if data.result == OK:
	print(data)
else:
	print("ERROR")

### Example code (Store Encrypted Data)

var storage : Storage = Storage.new("user://settings.data")
var result = storage.store_json({ "xxx": "yyy" })
if result != OK: print("Error")


### Thats all!
If you are felling it, please leave a donation!

[![PayPal button](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.me/davidkbd)



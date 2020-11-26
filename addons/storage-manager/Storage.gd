class_name Storage

var file_name : String
var password  : String
var is_secret : bool

# new_file_name param is the file to open (absolute path).
# new_password param is the password for encrypted files (optional).
func _init(new_file_name : String, new_password : String = ""):
	file_name = new_file_name
	password = new_password
	is_secret = password != ""

# Loads a json file.
func load_json() -> Dictionary:
	var r = load_text()
	if r.result == OK:
		r.data = parse_json(r.data)
		if not r.data: return _create_error(ERR_INVALID_DATA, file_name)
	return r

# Loads a text file.
func load_text() -> Dictionary:
	return _load(false)

# Loads a data (var) file.
func load_data() -> Dictionary:
	return _load(true)

func store_json(data : Dictionary) -> Dictionary:
	return store_text(to_json(data))

func store_text(data : String) -> Dictionary:
	return _store(data, false)

func store_data(data : Dictionary) -> Dictionary:
	return _store(data, true)

func _load(is_data : bool):
	var f = File.new()
	if not f.file_exists(file_name):
		return _create_error(ERR_FILE_NOT_FOUND, file_name)
	var err = f.open_encrypted_with_pass(file_name, File.READ, password) \
			if is_secret else f.open(file_name, File.READ)
	if err != OK:
		f.close()
		return _create_error(err, file_name)
	var readed = f.get_var() if is_data else f.get_as_text()
	f.close()
	if readed: return _create_ok(readed)
	return _create_error(ERR_INVALID_DATA, file_name)

func _store(data, is_data : bool) -> Dictionary:
	var f = File.new()
	var err = f.open_encrypted_with_pass(file_name, File.WRITE, password) \
			if is_secret else f.open(file_name, File.WRITE)
	if err != OK:
		f.close()
		return _create_error(err, file_name)
	if is_data:
		f.store_var(data)
	else:
		f.store_string(data)
	f.close()
	return _create_ok(null)

func _create_ok(data) -> Dictionary:
	if data:
		return { "result": OK, "data": data }
	return { "result": OK }

func _create_error(err : int, file_name : String) -> Dictionary:
	match err:
		ERR_INVALID_DATA:
			return _create_error_dictionary(err, "ERR_INVALID_DATA", file_name)
		ERR_FILE_ALREADY_IN_USE:
			return _create_error_dictionary(err, "ERR_FILE_ALREADY_IN_USE", file_name)
		ERR_FILE_BAD_DRIVE:
			return _create_error_dictionary(err, "ERR_FILE_BAD_DRIVE", file_name)
		ERR_FILE_BAD_PATH:
			return _create_error_dictionary(err, "ERR_FILE_BAD_PATH", file_name)
		ERR_FILE_CANT_OPEN:
			return _create_error_dictionary(err, "ERR_FILE_CANT_OPEN", file_name)
		ERR_FILE_CANT_READ:
			return _create_error_dictionary(err, "ERR_FILE_CANT_READ", file_name)
		ERR_FILE_CANT_WRITE:
			return _create_error_dictionary(err, "ERR_FILE_CANT_WRITE", file_name)
		ERR_FILE_CORRUPT:
			return _create_error_dictionary(err, "ERR_FILE_CORRUPT", file_name)
		ERR_FILE_EOF:
			return _create_error_dictionary(err, "ERR_FILE_EOF", file_name)
		ERR_FILE_MISSING_DEPENDENCIES:
			return _create_error_dictionary(err, "ERR_FILE_MISSING_DEPENDENCIES", file_name)
		ERR_FILE_NOT_FOUND:
			return _create_error_dictionary(err, "ERR_FILE_NOT_FOUND", file_name)
		ERR_FILE_NO_PERMISSION:
			return _create_error_dictionary(err, "ERR_FILE_NO_PERMISSION", file_name)
		ERR_FILE_UNRECOGNIZED:
			return _create_error_dictionary(err, "ERR_FILE_UNRECOGNIZED", file_name)
	return _create_error_dictionary(err, "FAILED", file_name)

func _create_error_dictionary(err, err_name : String, file_name : String) -> Dictionary:
	return { "result": err, "error": err_name, "file": file_name }

@tool
extends EditorScript

func _run():
	_get_all_scenes()

func _get_all_scenes():
	var folders = _get_folders_recursive("res:/")
	
	var scenes = []
	
	for i in folders:
		scenes.append_array(_get_scenes(i))
	
	for i in scenes:
		print(FileAccess.file_exists(i))
		
		EditorInterface.open_scene_from_path(i)

func _get_folders_recursive(path,recursionLayer = 0) -> Array:
	var folders = []
	
	var dir = DirAccess.open(path + "/")
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				folders.append_array(_get_folders_recursive(path + "/" + file_name, recursionLayer + 1))
				
				folders.push_back(path + "/" + file_name)
			file_name = dir.get_next()
	
	return folders

func _get_scenes(path) -> Array:
	var scene_loads = []
	
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				#print("Found directory: " + file_name)
				pass
			else:
				if file_name.get_extension() == "tscn":
					var full_path = path.path_join(file_name)
					scene_loads.append(full_path)
				elif file_name.get_basename().get_extension() == "tscn":
					var full_path = path.path_join(file_name.get_basename())
					scene_loads.append(full_path)
				
			file_name = dir.get_next()
	else:
		#print("An error occurred when trying to access the path.")
		pass
	
	return scene_loads

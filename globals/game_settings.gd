extends Node


const SAVE_PATH: String = 'user://gamesettings.json'

var data: Dictionary = {
    'fov': 100,
}


func save_game() -> void:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

    if file:
        file.store_string(JSON.stringify(data))
        file.close()


func load_game() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        return

    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    var content := file.get_as_text()
    file.close()

    var json = JSON.parse_string(content)
    if typeof(json) == TYPE_DICTIONARY:
        data = json

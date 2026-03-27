extends Node

var music_player = null
var sfx_player = null

func _ready():
    # 创建音频播放节点
    music_player = AudioStreamPlayer.new()
    music_player.name = "MusicPlayer"
    add_child(music_player)

    sfx_player = AudioStreamPlayer.new()
    sfx_player.name = "SFXPlayer"
    add_child(sfx_player)

# 播放背景音乐
func play_music(music_resource):
    if GameState.music_enabled:
        music_player.stream = music_resource
        music_player.play()

# 播放音效
func play_sfx(sfx_resource):
    if GameState.sound_enabled:
        sfx_player.stream = sfx_resource
        sfx_player.play()

# 停止音乐
func stop_music():
    music_player.stop()

# 暂停/恢复音效
func toggle_sound():
    GameState.sound_enabled = !GameState.sound_enabled

# 暂停/恢复音乐
func toggle_music():
    GameState.music_enabled = !GameState.music_enabled
    if !GameState.music_enabled:
        music_player.stop()
    else:
        music_player.play()

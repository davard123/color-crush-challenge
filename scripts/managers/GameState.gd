extends Node

# 游戏全局状态管理

var current_level = 1
var score = 0
var lives = 5
var coins = 0
var stars = 0  # 关卡星级评价

var has_premium = false  # 是否为高级会员
var sound_enabled = true
var music_enabled = true

# 关卡完成情况
var completed_levels = []
var unlocked_levels = 1  # 解锁的最高关卡

# 初始化游戏状态
func _ready():
    load_game_data()

# 保存游戏数据
func save_game_data():
    var save_data = {
        "current_level": current_level,
        "score": score,
        "lives": lives,
        "coins": coins,
        "stars": stars,
        "has_premium": has_premium,
        "sound_enabled": sound_enabled,
        "music_enabled": music_enabled,
        "completed_levels": completed_levels,
        "unlocked_levels": unlocked_levels
    }

    var file = File.new()
    file.open("user://savegame.save", File.WRITE)
    file.store_line(to_json(save_data))
    file.close()

# 加载游戏数据
func load_game_data():
    var file = File.new()
    if file.file_exists("user://savegame.save"):
        file.open("user://savegame.save", File.READ)
        var data = parse_json(file.get_as_text())

        if data.has("current_level"): current_level = data.current_level
        if data.has("score"): score = data.score
        if data.has("lives"): lives = data.lives
        if data.has("coins"): coins = data.coins
        if data.has("stars"): stars = data.stars
        if data.has("has_premium"): has_premium = data.has_premium
        if data.has("sound_enabled"): sound_enabled = data.sound_enabled
        if data.has("music_enabled"): music_enabled = data.music_enabled
        if data.has("completed_levels"): completed_levels = data.completed_levels
        if data.has("unlocked_levels"): unlocked_levels = data.unlocked_levels

        file.close()

# 添加积分
func add_score(points):
    score += points
    save_game_data()

# 添加金币
func add_coins(amount):
    coins += amount
    save_game_data()

# 添加星级
func add_star():
    stars += 1
    save_game_data()

# 更新生命值
func update_lives(change):
    lives += change
    if lives > 10:  # 生命值上限
        lives = 10
    save_game_data()

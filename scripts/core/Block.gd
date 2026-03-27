extends TextureButton

signal block_swapped(block1, block2)
signal block_clicked(block)

var block_type = 0  # 方块类型编号
var is_special = false  # 是否为特殊方块
var special_type = ""  # 特殊方块类型

var grid_pos = Vector2(0, 0)  # 在网格中的位置

func _ready():
    connect("pressed", self, "_on_block_pressed")

func _on_block_pressed():
    emit_signal("block_clicked", self)

# 设置方块类型
func set_block_type(type_id):
    block_type = type_id

    # 根据类型设置精灵
    var sprite_path = "res://assets/sprites/block_" + str(type_id) + ".png"
    if ResourceLoader.exists(sprite_path):
        texture_normal = load(sprite_path)

# 交换方块
func swap_with(other_block):
    var temp_type = block_type
    var temp_special = is_special
    var temp_special_type = special_type

    block_type = other_block.block_type
    is_special = other_block.is_special
    special_type = other_block.special_type

    other_block.block_type = temp_type
    other_block.is_special = temp_special
    other_block.special_type = temp_special_type

    emit_signal("block_swapped", self, other_block)

# 消除方块
func destroy():
    queue_free()

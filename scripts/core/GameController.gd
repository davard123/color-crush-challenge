extends Node2D

var board_size = Vector2(8, 8)
var board = []  # 游戏棋盘数组
var block_prefab = preload("res://scenes/game/Block.tscn")
var block_colors = 6  # 方块颜色种类数

var score = 0
var moves_left = 0

onready var board_container = $BoardContainer
onready var score_label = $UI/ScoreLabel
onready var moves_label = $UI/MovesLabel

func _ready():
    initialize_board()
    update_ui()

# 初始化游戏棋盘
func initialize_board():
    # 创建二维数组
    board = []
    for x in range(board_size.x):
        var row = []
        for y in range(board_size.y):
            row.append(null)
        board.append(row)

    # 生成方块
    for x in range(board_size.x):
        for y in range(board_size.y):
            create_block_at(x, y)

# 在指定位置创建方块
func create_block_at(x, y):
    var new_block = block_prefab.instance()
    new_block.grid_pos = Vector2(x, y)
    new_block.set_block_type(randi() % block_colors + 1)

    # 防止初始出现匹配
    while would_create_match_at(x, y, new_block.block_type):
        new_block.set_block_type(randi() % block_colors + 1)

    new_block.position = Vector2(x * 80 + 40, y * 80 + 40)  # 80x80像素方块，带间隔
    new_block.connect("block_clicked", self, "on_block_clicked")

    board_container.add_child(new_block)
    board[x][y] = new_block

# 检查是否会在此位置形成匹配
func would_create_match_at(x, y, block_type):
    # 检查水平方向
    var horizontal_matches = 1
    # 检查左边
    var left_x = x - 1
    while left_x >= 0 and board[left_x][y] != null and board[left_x][y].block_type == block_type:
        horizontal_matches += 1
        left_x -= 1
    # 检查右边
    var right_x = x + 1
    while right_x < board_size.x and board[right_x][y] != null and board[right_x][y].block_type == block_type:
        horizontal_matches += 1
        right_x += 1

    if horizontal_matches >= 3:
        return true

    # 检查垂直方向
    var vertical_matches = 1
    # 检查上方
    var up_y = y - 1
    while up_y >= 0 and board[x][up_y] != null and board[x][up_y].block_type == block_type:
        vertical_matches += 1
        up_y -= 1
    # 检查下方
    var down_y = y + 1
    while down_y < board_size.y and board[x][down_y] != null and board[x][down_y].block_type == block_type:
        vertical_matches += 1
        down_y += 1

    if vertical_matches >= 3:
        return true

    return false

# 方块点击事件
var selected_block = null
func on_block_clicked(clicked_block):
    if selected_block == null:
        selected_block = clicked_block
        # 高亮选中方块
        highlight_block(selected_block)
    else:
        if is_adjacent(selected_block, clicked_block):
            # 交换方块
            selected_block.swap_with(clicked_block)

            # 检查是否形成匹配
            var matches = find_matches()
            if matches.size() > 0:
                # 有效移动，执行消除
                process_matches(matches)
            else:
                # 无效移动，换回方块
                selected_block.swap_with(clicked_block)

        clear_highlight()
        selected_block = null

# 检查两个方块是否相邻
func is_adjacent(block1, block2):
    var pos1 = block1.grid_pos
    var pos2 = block2.grid_pos

    var distance = abs(pos1.x - pos2.x) + abs(pos1.y - pos2.y)
    return distance == 1

# 高亮方块
func highlight_block(block):
    # 这里可以添加视觉高亮效果
    pass

# 清除高亮
func clear_highlight():
    # 清除之前的高亮
    pass

# 查找所有匹配的方块
func find_matches():
    var matches = []

    # 水平匹配
    for y in range(board_size.y):
        var count = 1
        var start_x = 0
        for x in range(1, board_size.x):
            if board[x][y] != null and board[x-1][y] != null:
                if board[x][y].block_type == board[x-1][y].block_type:
                    count += 1
                else:
                    if count >= 3:
                        for i in range(count):
                            matches.append(board[start_x+i][y])
                    count = 1
                    start_x = x

    # 垂直匹配
    for x in range(board_size.x):
        var count = 1
        var start_y = 0
        for y in range(1, board_size.y):
            if board[x][y] != null and board[x][y-1] != null:
                if board[x][y].block_type == board[x][y-1].block_type:
                    count += 1
                else:
                    if count >= 3:
                        for i in range(count):
                            matches.append(board[x][start_y+i])
                    count = 1
                    start_y = y

    return matches

# 处理匹配结果
func process_matches(matches):
    if matches.size() > 0:
        # 计算分数
        var points = matches.size() * 10
        if matches.size() >= 4:
            points *= 2  # 连消奖励
        add_score(points)

        # 消除匹配的方块
        for block in matches:
            if block != null:
                block.destroy()
                board[block.grid_pos.x][block.grid_pos.y] = null

        # 填补空缺
        fill_empty_spaces()

        # 检查是否有新的匹配
        yield(get_tree().create_timer(0.5), "timeout")  # 等待消除动画
        var new_matches = find_matches()
        if new_matches.size() > 0:
            process_matches(new_matches)  # 递归处理连锁反应

# 填补空缺
func fill_empty_spaces():
    for x in range(board_size.x):
        var empty_count = 0
        for y in range(board_size.y - 1, -1, -1):  # 从底部开始
            if board[x][y] == null:
                empty_count += 1
            elif empty_count > 0:
                # 移动方块
                var target_y = y + empty_count
                board[x][target_y] = board[x][y]
                board[x][y] = null
                board[x][target_y].grid_pos.y = target_y
                board[x][target_y].position.y += empty_count * 80

        # 在顶部创建新方块填补空缺
        for i in range(empty_count):
            create_block_at(x, i)

# 添加分数
func add_score(points):
    score += points
    update_ui()

# 更新UI
func update_ui():
    score_label.text = "分数: " + str(score)
    moves_label.text = "剩余步数: " + str(moves_left)

# 设置剩余步数
func set_moves(moves):
    moves_left = moves
    update_ui()

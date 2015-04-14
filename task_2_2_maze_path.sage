def get_block(row, col, color):
    return polygon([[col, -row], [col + 1, -row], [col + 1, -row - 1], [col, -row - 1]], rgbcolor=color)

def get_maze_draw(maze_repr):
    g = Graphics()
    row = 0
    lines = [l for l in maze_repr.split("\n") if l]
    for line in lines:
        for col in range(len(line)):
            if line[col] == '#':
                g += get_block(row, col, (0,0,0))
            elif line[col] == '.':
                g += get_block(row, col, (1,1,0))
        row += 1
    return g

ga = Graphics()
frames = []
FPS = 2

def build_path(maze_repr, start, finish):
    global ga
    global frames
    ga += get_maze_draw(maze_repr) + get_block(finish[1], finish[0], (1, 0, 0)) + get_block(start[1], start[0], (1, 0, 0))
    frames = [ga]
    maze = [list(s) for s in maze_repr.split("\n") if s]
    step = 1
    plan = [start]
    maze[int(start[1])][int(start[0])] = step
    while plan:
        step += 1
        v = plan.pop()
        ga += get_block(v[1], v[0], (0, 1, 0))
        frames += [ga]
        for vn in get_neighbours(maze, v):
            tmp = maze[vn[1]][vn[0]]
            maze[vn[1]][vn[0]] = step
            if vn == finish:
                plan = []
                ga += get_block(vn[1], vn[0], (0, 1, 0))
                frames += [ga]
                break
            if tmp == '.':
                plan += [vn]
    animate(frames).show(delay=int(100 / FPS))

def get_neighbours(maze, pos):
    neighbours = []
    h = len(maze)
    w = len(maze[0])
    if pos[0] > 0 and maze[pos[1]][pos[0] - 1] != '#':
        neighbours += [[pos[0] - 1, pos[1]]]
    if pos[0] < w - 1 and maze[pos[1]][pos[0] + 1] != '#':
        neighbours += [[pos[0] + 1, pos[1]]]
    if pos[1] > 0 and maze[pos[1] - 1][pos[0]] != '#':
        neighbours += [[pos[0], pos[1] - 1]]
    if pos[1] < h - 1 and maze[pos[1] + 1][pos[0]] != '#':
        neighbours += [[pos[0], pos[1] + 1]]
    return neighbours

maze = """
...#.#.#.#.....
.###.#.#.#.#.##
...#.#...#.#.#.
##.#.#.###.###.
.........#.#.#.
.###.#####.#.#.
.#.............
####.#.#.###.##
.....#.#...#...
####.#.#.#.###.
.....#.#.#...#.
.#.#.###.###.##
.#.#.#.....#...
.#######.###.#.
.#.........#.#.
"""

maze_small = """
..##.
#.#.#
..#..
.#...
...#.
"""

build_path(maze, [0, 0], [14, 14])


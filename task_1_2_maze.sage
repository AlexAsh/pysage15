def get_block(row, col, color):
    return polygon([[col, -row], [col + 1, -row], [col + 1, -row - 1], [col, -row - 1]], rgbcolor=color)

def draw_maze(maze_repr):
    g = Graphics()
    row = 0
    for line in maze_repr.split("\n"):
        for col in range(len(line)):
            if line[col] == '#':
                g += get_block(row, col, (0,0,0))
            elif line[col] == '.':
                g += get_block(row, col, (1,1,0))
        row += 1
    g.axes(False)
    g.show()

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

draw_maze(maze)

from math import pi, cos, sin


def show_graph(gr):
    g = Graphics()
    n = len(gr.vertices())
    a = 2 * pi / n
    R = 10.0
    r = pi * R / (4 * (n - 1))
    for v in gr.vertices():
        g += circle((R * cos(v * a), R * sin(v * a)), r, fill=True, rgbcolor=(0, 0, 0))
    for e in gr.edges():
        g += line([[R * cos(e[0] * a), R * sin(e[0] * a)], [R * cos(e[1] * a), R * sin(e[1] * a)]], rgbcolor=(0, 0, 0))
    g.axes(False)
    g.show()

gr = Graph({0: [1, 2, 3], 2: [1, 3]})
show_graph(gr)


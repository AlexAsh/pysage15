from math import pi, cos, sin

ga = Graphics()
frames = []
stop = False
seen = []
alpha = 2 * pi
RADIUS = 10.0

def get_graph_img(gr, sv, tv):
    global RADIUS
    g = Graphics()
    n = len(gr.vertices())
    a = 2 * pi / n
    R = RADIUS
    r = pi * R / (4 * (n - 1))
    for v in gr.vertices():
        color = (0, 1, 0) if v == sv or v == tv else (0, 0, 0)
        g += circle((R * cos(v * a), R * sin(v * a)), r, fill=True, rgbcolor=color)
    for e in gr.edges():
        g += line([[R * cos(e[0] * a), R * sin(e[0] * a)], [R * cos(e[1] * a), R * sin(e[1] * a)]], rgbcolor=(0, 0, 0))
    g.axes(False)
    return g


def view_vertex(gr, v, tv):
    global ga
    global stop
    global frames
    global seen
    global RADIUS
    R = RADIUS
    if v == tv or stop:
        stop = True
    else:
        if v not in seen:
            seen += [v]
        vs = [vi for vi in gr.vertex_boundary([v]) if vi not in seen]
        if vs:
            for vn in vs:
                if stop:
                    break
                ga += line([[R * cos(v * alpha), R * sin(v * alpha)], [R * cos(vn * alpha), R * sin(vn * alpha)]], rgbcolor=(1, 0, 0))
                frames += [ga]
                view_vertex(gr, vn, tv)


def seek_path(gr, sv, tv):
    global ga
    global stop
    global frames
    global seen
    global alpha
    alpha = 2 * pi / len(gr.vertices())
    ga += get_graph_img(gr, sv, tv)
    frames = [ga]
    stop = False
    seen = []
    view_vertex(gr, sv, tv)
    animate(frames).show(delay=100)
    return stop

gr = Graph({0: [1, 2, 3, 11], 2: [1, 3], 3: [4, 5, 6], 5: [1, 6, 7], 7: [1, 8]})
seek_path(gr, 4, 8)


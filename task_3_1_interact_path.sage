import random
from math import pi, cos, sin

ga = Graphics()
stop = False
seen = []
RADIUS = 10.0

def get_graph_img(gr, sv, tv, R = RADIUS):
    g = Graphics()
    n = len(gr.vertices())
    a = 2 * pi / n
    r = pi * R / (4 * (n - 1))
    for v in gr.vertices():
        color = (0, 1, 0) if v == sv or v == tv else (0, 0, 0)
        g += circle((R * cos(v * a), R * sin(v * a)), r, fill=True, rgbcolor=color)
    for e in gr.edges():
        g += line([[R * cos(e[0] * a), R * sin(e[0] * a)], [R * cos(e[1] * a), R * sin(e[1] * a)]], rgbcolor=(0, 0, 0))
    g.axes(False)
    return g


def view_vertex(gr, v, tv, R = RADIUS):
    global ga
    global stop
    global seen
    frames = []
    alpha = 2 * pi / len(gr.vertices())
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
                frames += view_vertex(gr, vn, tv)
    return frames


def seek_path(gr, sv, tv):
    global ga
    global stop
    global seen
    ga = Graphics()
    stop = False
    seen = []
    ga += get_graph_img(gr, sv, tv)
    frames = [ga] + view_vertex(gr, sv, tv)
    animate(frames).show(delay=100)
    print seen, len(frames)
    return stop

@interact
def path_build_interact(seed = input_box('1', type = int, label = 'seed (int)'), \
                  vertices = input_box('7', type = int, label = 'vertices (int)'), \
                  density = slider(0, 1, 0.05, 0.5)):
    max_edges = int(vertices * (vertices - 1) / 2)
    edges = int(round(density * max_edges))
    edges_presence = [True] * edges + [False] * (max_edges - edges)
    graph_repr = {i: [] for i in range(vertices)}
    random.seed(seed)
    random.shuffle(edges_presence)
    for i in range(vertices - 1):
        for j in range(i + 1, vertices):
            if (edges_presence.pop()):
                graph_repr[i] += [j]
    gr = Graph(graph_repr)
    seek_path(gr, 0, vertices - 1)


# Класс, представляющий ребро графа (начало, конец, вес, было ли ребро пройдено)
class Edge:
    def __init__(self, begin, end, weight):
        self.begin = begin
        self.end = end
        self.weight = weight
        self.checked = False


# Класс, представляющий граф
class DSU:
    def __init__(self, nodes_count):
        # Родитель вершин (т. е. к какой группе она принадлежит)
        self.parent = []
        # Ранг вершин
        self.rank = []
        for i in range(nodes_count):
            # Изначально все вершины принадлежат разным группам и имеют ранг 0
            self.parent.append(i)
            self.rank.append(0)

    def find(self, v):
        # Если текущая вершина является корнем группы, то возвращаем её
        if self.parent[v] == v:
            return v

        # Иначе вызываем функцию поиска компоненты и задаем родителя текущей вершины
        self.parent[v] = self.find(self.parent[v])
        return self.parent[v]

    def unite(self, v, u):
        # Ищем компоненты связности для вершин
        v = self.find(v)
        u = self.find(u)
        if v == u:
            return False

        # Если вершины не в одной компоненте связности, то объединяем их
        if self.rank[v] < self.rank[u]:
            # Если ранг вершины u больше, чем у вершины v, то меняем их местами
            self.parent[v] = u
        elif self.rank[v] > self.rank[u]:
            # Также и наоборот
            self.parent[u] = v
        else:
            # Если ранги равны, то увеличиваем ранг одной из вершин
            self.parent[v] = u
            self.rank[u] += 1
        return True


def minSpanningTree():
    # Ввод количества вершин и ребер графа соотвественно
    nodes_count, edges_count = map(int, input().split())

    edges = []
    # Ввод ребер графа (начало, конец, вес)
    for i in range(edges_count):
        begin, end, weight = map(int, input().split())
        edges.append(Edge(begin - 1, end - 1, weight))

    # Сортировка ребер по весу
    edges.sort(key=lambda e: e.weight)

    # Создание графа
    dsu = DSU(nodes_count)

    # Ребра минимального остовного дерева
    minSpanningTreeEdges = []

    for i in range(nodes_count):
        # Проходимся по ребрам графа
        for edge in edges:
            if edge.checked:
                continue

            # Если ребро не пройдено и его концы не в одной компоненте связности
            if dsu.unite(edge.begin, edge.end):
                # Добавляем ребро в минимальное остовное дерево
                minSpanningTreeEdges.append(edge)
                # Отмечаем ребро как пройденное
                edge.checked = True
                break

            edge.checked = True

    # Выводим ребра минимального остовного дерева и его вес
    weight = 0
    for edge in minSpanningTreeEdges:
        print(edge.begin + 1, edge.end + 1, edge.weight)
        weight += edge.weight
    print(weight)


if __name__ == '__main__':
    minSpanningTree()

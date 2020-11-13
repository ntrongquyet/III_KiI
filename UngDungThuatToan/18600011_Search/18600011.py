import matplotlib.pyplot as plt 
class Graph: 
  def __init__(self, A): 
    self.A = A
    self.N = len(A)

  def BFS(self, start, goal): 
     # keep track of all visited nodes
    explored = []
    # keep track of nodes to be checked
    queue = [start]
 
    # keep looping until there are nodes still to be checked
    while queue:
        # pop shallowest node (first node) from queue
        node = queue.pop(0)
        if node not in explored:
            # add node to list of checked nodes
            explored.append(node)
            for x in self.A:
                neighbours = x
                for neighbour in neighbours:
                        queue.append(neighbour)
            # add neighbours of node to queue
           
    return explored

#   def DFS(self, start, goal): 
#     pass
  
#   def UCS(self, start, goal):
#     pass

#   def AStar(self, start, goal):
#     pass

# Ma trận cạnh kề của đồ thị vô hướng có trọng số
# A[i][j] = k với k > 0 có cạnh và k<=0 là không có cạnh. 

A = [
  [0, 1, 0, 1],
  [1, 0, 0, 0],
  [0, 0, 0, 1],
  [1, 0, 1, 0]
]
def MatrixToGraph(A):
    graph = {}
    arr = []
    for i in range(len(A)):
        arr.clear()
        for j in range(len(A[i])):
            if A[i][j] > 0:
                arr.append(j + 1)
        graph[i + 1] = arr.copy()
        
    return graph
    
g = MatrixToGraph(A)
arrX = []
arrY = []
for x, y in g.items():
    for i in range(0, len(y)):
        arrX.append(x)
        arrY.append(y[i])
plt.plot(arrX,arrY,marker = 'o', ms = 20, mec = 'r')
plt.show()
# print(A)
# g = Graph(A)
# x = [1,2,1,4,4,3]
# y = [2,1,4,1,3,4]
# plt.plot(x,y)
# plt.show()
# print(g.BFS(0, 5))
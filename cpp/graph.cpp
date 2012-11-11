#include <vector>
#include <map>
#include <queue>
#include <set>
#include <stdlib.h>
#include <iostream>
#include <stdio.h>
using namespace std;

class Node {
  public:
    Node(int _id=0, int _data=0) 
      : id(_id)
      , data(_data)
    { }
    
    ~Node() {};
    
    int id;
    int data;
};



class Graph {
  public:
    // Create a node
    // Get adjacent nodes (id)
    // Get all nodes ()
    // Set adjacent (node1, node2)


    Node* create_node(int data) {
      Node node(unique_id, data);

      m_nodes.push_back(node);
      m_id_to_node_map[unique_id] = &m_nodes.back();
      m_id_to_adjacent_map[unique_id];

      unique_id++;
      return &m_nodes.back();
    }

    const set<int>* get_adjacent_nodes(int id) {
      if (m_id_to_adjacent_map.find(id) != m_id_to_adjacent_map.end())
        return &m_id_to_adjacent_map[id];
      return NULL;
    }

    void set_adjacent(int id1, int id2) {
      if (has_node(id1) && has_node(id2)) {
        m_id_to_adjacent_map[id1].insert(id2);
      }
    }

    const vector<Node>& get_all_nodes() {
      return m_nodes;
    }

    bool has_node(int id) {
      return m_id_to_node_map.find(id) != m_id_to_node_map.end();
    }

  private:
    static int unique_id;
    vector<Node>             m_nodes;
    map<int, Node*>          m_id_to_node_map;
    map<int, set<int> > m_id_to_adjacent_map;
};
int Graph::unique_id = 0;

int main() {
  Graph my_graph;
  for (int i = 0; i < 10; i++) {
    Node* n = my_graph.create_node(-i);
    cout << "id: " << n->id << " data: " << n->data << endl;
  }
}


#include<vector>
#include<map>
#include<queue>
#include <stdlib.h>
#include <iostream>
#include <stdio.h>
using namespace std;

class GraphNode {

  public:
    GraphNode() {};
    GraphNode(int d)
    : data(d), 
    {}

    ~GraphNode() {};
    int data;
    static int id;



};

class Graph {
  public:
    //GraphNode* head;
    map<GraphNode*, vector<GraphNode*> > adjacancy;

    // look for a data and if find it return the distance otherwise return -1
    //int bfs(int s_data) {
      //if (head->data == s_data)
        //return 0;

      //queue<GraphNode*> visiting;
      //map<GraphNode*, bool> visited_map;
      //visiting.push(head);
      //visited_map[head] = 0;
      

      //while(!visiting.empty()) {
        //GraphNode* curr_node = visiting.front();
        //cout << curr_node->data << endl;
        //visiting.pop();

        //vector<GraphNode*> curr_children = curr_node->children;
        //cout << "children size: " << curr_children.size() << endl;
        //for(int i = 0; i < curr_children.size(); i++) {
          //GraphNode* curr_child = curr_children[i];
          //if (curr_child->data == s_data)
            //return visited_map[curr_node]+1;
          //if (visited_map.find(curr_child) == visited_map.end()) {
            //visiting.push(curr_child);
            //visited_map[curr_child] = visited_map[curr_node]+1;
          //}
        //}
      //}
      //return -1;
    //}

    void dfs() {
    }
  

};

//Graph* create_graph() {
  //GraphNode* root = new GraphNode(10);
  //int ch[] = {1,2,3,4,5};
  //vector<GraphNode*> children(5);
  //for(int i =  0; i < 5; i++) {
    //children[i] = new GraphNode(ch[i]);
  //}
  //root->children = children;

  //int ch2[] = {10,20,30,40,50};
  //vector<GraphNode*> children2(5);
  //for(int i =  0; i < 5; i++) {
    //children2[i] = new GraphNode(ch2[i]);
  //}
  //root->children[0]->children = children2;


  //Graph* g = new Graph();
  //g->head = root;
  //return g;
//}

void create_adjacancy_graph(map<GraphNode*, vector<GraphNode*> >& graph) {

  vector<GraphNode*>* list_of_nodes = new vector<GraphNode*>();
  
  for (int i = 0; i < 20; i++) {
    GraphNode* new_node = new GraphNode(i);
    graph[new_node] = new vector<GraphNode*>(); 
    list_of_nodes->insert(new_node);
  }
  
  return graph;
}

int main() {
  Graph* graph = new Graph();
  map<GraphNode*, vector<GraphNode*> >  adjacancy;
  graph->adjacancy = create_adjacancy_graph();
}

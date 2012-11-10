#include <iostream>
#include <vector>
#include <queue>
#include <stack>
using namespace std;

class TreeNode {
  public:
    int data;
    TreeNode* left;
    TreeNode* right;

    TreeNode(int value) {
      data = value;
    }


  private:
};

class Tree {
  public: 
    Tree() {}
    ~Tree() {}

  void insert_recursive(int data) {
    if (!root) 
    {
      root = new TreeNode(data);
    } 
    else 
    {
      do_insert_recursive(root, data); 
    }
  }
  
  TreeNode* find(int item) {
    if (!root)
      return NULL;
    return NULL;
  }

  int max_height() {
    cout << "max height is: ";
    int rval = max_height_helper(root);
    cout << rval << endl;
    return rval;
  }

  int min_height() {
    cout << "min height is: ";
    int rval = min_height_helper(root);
    cout << rval << endl;
    return rval;
  }

  bool is_balanced() {
    int min_h = min_height();
    int max_h = max_height();

    return ((max_h - min_h) == 1);
  }

  int min_height_helper(TreeNode* curr_root) {
    if (!curr_root)
      return 0;
    return 1 + min( min_height_helper(curr_root->right),
                    min_height_helper(curr_root->left)) + 1;
  }
  
  int max_height_helper(TreeNode* curr_root) {
    if (!curr_root)
      return 0;
    return 1 + max( max_height_helper(curr_root->left), 
                    max_height_helper(curr_root->right));
  }

  void print_level_by_leve() {
    cout << "tree level by level" << endl;
    if (!root)
      return;

    queue<TreeNode*> curr_level;
    queue<TreeNode*> next_level;

    curr_level.push(root);
    cout << root->data << endl;

    while (!curr_level.empty()) {
      TreeNode* curr_node = curr_level.front();
      curr_level.pop();
      if (curr_node->left)
        next_level.push(curr_node->left); 
      if (curr_node->right)
        next_level.push(curr_node->right); 

      if (curr_level.empty() && !next_level.empty()) {
         while (!next_level.empty()) {
          cout << next_level.front()->data << " ";
          curr_level.push(next_level.front());
          next_level.pop();
         }
         cout << endl;
      }
    }
  }

  void post_order_traversal() {
   cout << "post order" << endl;
   post_order_traversal(root);
   cout << endl;
  }

  void in_order_traveral() {
    cout << "in order" << endl;
    in_order_traversal(root);
    cout << endl;
  }

  void pre_order_traversal() {
    cout << "pre order" << endl;
    pre_order_traversal(root);
    cout << endl;
  }

  private:
    TreeNode* root;

    void post_order_traversal(TreeNode* root) {
      if (!root)
        return;

      if (root->left)
        post_order_traversal(root->left);
      if (root->right)
        post_order_traversal(root->right);
      cout << root->data << " ";
    }

    void pre_order_traversal(TreeNode* root) {
      cout << root->data << " "; 
      if (root->left)
        pre_order_traversal(root->left);
      if (root->right)
        pre_order_traversal(root->right);
    }

    void in_order_traversal(TreeNode* root) {
      if (root->left) 
        in_order_traversal(root->left);
      cout << root->data << " ";
      if (root->right)
        in_order_traversal(root->right);
    }
  
    void do_insert_recursive(TreeNode* node, int data) {
      if (node->data < data) {
        if (node->right) {
          do_insert_recursive(node->right, data);
        } else {
          node->right = new TreeNode(data);
        }
      } else {
        if (node->left) {
          do_insert_recursive(node->left, data);
        } else {
          node->left = new TreeNode(data);
        }

      }
    }

};

Tree* create_new_tree() {
  Tree* new_tree = new Tree();
  int arr[] = {100, 90, 93, 77, 74, 110, 120, 115, 109};
  for (int i = 0; i < 9; i++) {
    new_tree->insert_recursive(arr[i]);
  }
  return new_tree;  
}

int main() {
  // Tree m_bst(); didn't work for initializing
  Tree* m_bst = create_new_tree();
  m_bst->print_level_by_leve();
  m_bst->post_order_traversal();
  m_bst->pre_order_traversal();
  m_bst->in_order_traveral();
  m_bst->min_height();
  m_bst->max_height();
  cout << "tree is balance: " << m_bst->is_balanced() << endl;
}

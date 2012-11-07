#include <iostream>
#include <vector>
#include <stack>

class TreeNode {
  public:

    TreeNode(int value) {
      data = value;
    }


  private:
    int data;
    TreeNode* left;
    TreeNode* right;
};

class Tree {
  public: 
    Tree {}
    ~Tree {}

  void insert_recursive(int data) {
    if (!root) 
    {
      root = new TreeNode(10);
    } 
    else 
    {
      do_insert_recursive(root, data); 
    }
  }

  void in_order_traveral() {
    in_order_traversal(root);
  }

  void pre_order_traversal() {
    pre_order_traversal(root);
  }

  private:
    TreeNode* root;

    void pre_order_traversal(TreeNode* root) {
      cout << root->data << " "; 
      if (root->left)
        pre_order_traversal(root->left);
      if (root->right)
        pre_order_traversal(root->right);
    }

    void in_order_traversal(TreeNode* root) {
      if (root->left) 
        pre_order_traversal(root->left);
      cout << root->data << " ";
      if (root->right)
        pre_order_traversal(root->right);
    }
  
    void do_insert_recursive(TreeNode* node, int data) {
      if (node->data < data) {
        if (node->right) {
          do_insert_recursive(node->right, data);
        } else {
          node->rigth = new TreeNode(data);
        }
      } else {
        if (node->left) {
          do_insert_recursive(node->left, data);
        } else {
          node->left = new TreeNode(data)
        }

      }
    }

}

int main() {
  Tree m_bst();
  m_bst.insert_recursive(10);
}

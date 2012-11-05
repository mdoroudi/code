#include <iostream>
#include <map>
#include <string>

using namespace std;


class LLNode {
  public:
    explicit LLNode(int d=0, LLNode* n=0)
    : data(d), next(n)
    {}

    
    ~LLNode() {
    }

    int data;
    LLNode* next;

};

class LinkedList {
  public:
    LinkedList()
    {}


};


// Write a function that takes a LLNode (the head of a list),
// reverses the list, and returns the new head of the list.

LLNode* reverse(LLNode* head) {
  if (head == NULL || head->next == NULL)
    return head;

  LLNode* prev = NULL;
  LLNode* curr = head;
  LLNode* next = head->next;
  
  while(next) {
    curr->next = prev;
    prev = curr;
    curr = next;
    next = next->next;
  }

  curr->next = prev;
  return curr;
}


void print_linked_list(LLNode* head) {
  LLNode* curr = head;
  while (curr) {
    cout << curr->data << " -> ";
    curr = curr->next;
  }
  cout << "//" << endl;
}

LLNode* create_a_linked_list(int* data, int ll_size) {

  LLNode* head = NULL;
  LLNode* curr = NULL;

  for (int i = 0; i < ll_size; i++) {
    LLNode* n = new LLNode(data[i]);
    if (head == NULL) {
      head = n;
      curr = n; 
    } else {
      curr->next = n;
      curr = n;
    }
  }
  return head;

}

// remove first occurance of a data
LLNode* delete_node(LLNode* head, int data) {

  if (head == NULL)
    return head;

  if (head->data == data) {
    if (head->next == NULL) {
      delete head;
      return NULL;
    } else {
      LLNode* next = head->next;
      delete head;
      head = next;
      return head;
    }
  }

  LLNode* curr = head;
  LLNode* prev = NULL;

  while (curr) {
    if(curr->data == data) {
      LLNode* next = curr->next;
      delete curr;
      prev->next = next;
      return head;
    } else {
      prev = curr;
      curr = curr->next;
    }
  }

  return head;

}

int length(LLNode* ll) {
  int length = 0;
  while (ll) {
    length++;
    ll = ll->next;
  }

  return length;
}

LLNode* find_nth_node_to_the_last(LLNode* ll, int n) {
  if (length(ll) == n) {
    return NULL;
  }

  LLNode* n_ahead = ll;
  while (n > 0) {
    n_ahead = n_ahead->next;
    n--;
  }

  while (n_ahead->next) {
    n_ahead = n_ahead->next;
    ll = ll->next;
  }

  return ll;
}

int find_nth_to_the_last(LLNode* ll, int n) {
  LLNode* res = find_nth_node_to_the_last(ll, n);
  if (res == NULL)
    return -1;
  else
    return res->data;
}

LLNode* rotate_k_times(LLNode* ll, int rotate_times) {
  int len = length(ll);
  rotate_times = rotate_times%len;

  if (rotate_times == 0)
    return ll;
  else {
    LLNode* break_node = find_nth_node_to_the_last(ll, rotate_times);
    LLNode* new_head = break_node->next;
    LLNode* old_tail = find_nth_node_to_the_last(ll, 0);
    break_node->next = NULL;
    old_tail->next = ll;
    return new_head;
  }
}
  
// delete a node from the middle of the list
int delete_curr_node(LLNode* curr_node) {
  curr_node->data = curr_node->next->data;
  LLNode* next = curr_node->next;
  curr_node->next = next->next;
  delete next;
}

void remove_duplicates(LLNode* ll) {
  map<int, bool> ll_map;
  LLNode* prev = NULL;
  while(ll) {
    int curr_data = ll->data;
    if (ll_map.find(curr_data) == ll_map.end()) {
      ll_map[curr_data] = true;
      prev = ll;
      ll = ll->next;
    } else {
      if (ll->next == NULL) {
        delete ll;
        prev->next = NULL; 
        return;
      } else {
        delete_curr_node(ll);
      }
    }
  }
}

LLNode* swap_consecutive_elements(LLNode* ll) {
  if (ll == NULL || ll->next == NULL)
    return ll;
  while(ll && ll->next) {
    int tmp = ll->data;
    ll->data = ll->next->data;
    ll->next->data = tmp;
    ll = ll->next->next;
  }
}

int main() {
  int data[] = {1,2,3,4,5, 6, 7, 7};
  LLNode* ll = create_a_linked_list(data, 8); 
  print_linked_list(ll);
  //ll = reverse(ll);
  //print_linked_list(ll);
  print_linked_list(delete_node(ll, 3));
  cout << "linked list length: " <<length(ll) << endl;
  cout << "0th to the last node: "<< find_nth_to_the_last(ll, 0) << endl;
  //cout << "removed duplicates ll: ";
  //remove_duplicates(ll);
  //print_linked_list(ll);
  //ll = rotate_k_times(ll, 14);
  swap_consecutive_elements(ll);
  print_linked_list(ll);
}

#ifndef LINKED_LIST_H
#define LINKED_LIST_H

class LLNode {
  public:
    LLNode();
    ~LLNode(); 

    int get_data() const;

    int data;
    LLNode* next;
};

#endif

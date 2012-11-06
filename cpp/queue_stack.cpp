#include <iostream>
#include <vector>
using namespace std;

using std::cout;
using std::endl;

class Stack {
  public:
    void push(int data) {
      //m_stack.push_back(data); 
      m_stack.insert(m_stack.end(), data);
    }

    int peek() {
      m_stack.back();
    }

    int pop() {
      int val = m_stack.back();
      m_stack.pop_back();
      return val;
    }

  private:
    vector<int> m_stack;
};

class Queue {
  
  public:

    int dQueue() {
      int val = peek();
      m_queue.erase(m_queue.begin());
      return val;
    }

    void enQueue(int data) {
      m_queue.push_back(data);
    }

    int peek() {
      m_queue.front();
    }

  private:
    vector<int> m_queue;
};


class ThreeStack {
  public:

    ThreeStack() 
      :each_stack_size(10)
    {
      vector<int> m_stack(each_stack_size*3);
      
      int start_i[] = {0, each_stack_size, each_stack_size*2};
      vector<int> start_index(start_i, start_i+3);

      int end_i[] = {each_stack_size-1, each_stack_size*2-1, each_stack_size*3-1};
      vector<int> end_index(end_i, end_i+3);

      vector<int> curr_index(start_index);
    }

    void push(int stack_n, int value) {
      if (curr_index[stack_n] <= end_index[stack_n]) {
        m_stack[curr_index[stack_n]] = value;
        curr_index[stack_n]++;
      } else {
        resize_stack();
        m_stack[curr_index[stack_n]] = value;
        curr_index[stack_n]++;
      }
    }

    int pop(int stack_n) {
      if ((curr_index[stack_n]-1) >= start_index[stack_n]) {
        int value = m_stack[curr_index[stack_n]-1];
        curr_index[stack_n]--;
        return value;
      }
      return 0;
    }

    void print_stacks() {
      cout << "stack 1: ";
      for (int i = 0; i < curr_index[0]; i++)
        cout << m_stack[curr_index[0]] << " ";
      cout << endl;

      cout << "stack 2: ";
      for (int i = 0; i < curr_index[1]; i++)
        cout << m_stack[curr_index[1]] << " ";
      cout << endl;
      
      cout << "stack 3: ";
      for (int i = 0; i < curr_index[2]; i++)
        cout << m_stack[curr_index[2]] << " ";
      cout << endl;
    }

  private:
    vector<int> m_stack;
    vector<int> start_index;
    vector<int> end_index;
    vector<int> curr_index;
    int each_stack_size;

    void resize_stack() {
      m_stack.resize(m_stack.size()*2);

      for (int i = start_index[1]; i < curr_index[1]; i++) {
        m_stack[i+start_index[1]] = m_stack[i];
      }

      for (int i = start_index[2]; i < curr_index[2]; i++) {
        m_stack[i+start_index[2]] = m_stack[i];
      }

      for (int i = 0; i < start_index.size(); i ++) {
        curr_index[i] = curr_index[i] + start_index[i]; 
        start_index[i] *= 2;
        end_index[i] *= 2;
      }   
      each_stack_size *= 2;
    }
};

int main() {
  ThreeStack* my_stack = new ThreeStack();
  my_stack->print_stacks();
}

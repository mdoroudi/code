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
      :each_stack_size(10), start_index(3), end_index(3), curr_index(3)
    {
      m_stack.resize(each_stack_size*3);
      
      start_index[0] = 0;
      start_index[1] = each_stack_size;
      start_index[2] = each_stack_size*2;

      end_index[0] = each_stack_size - 1;
      end_index[1] = each_stack_size*2 - 1;
      end_index[2] = each_stack_size*3 - 1;

      curr_index = start_index;
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
      for (int i = start_index[0]; i < curr_index[0]; i++)
        cout << m_stack[i] << " ";
      cout << endl;

      cout << "stack 2: ";
      for (int i = start_index[1]; i < curr_index[1]; i++)
        cout << m_stack[i] << " ";
      cout << endl;
      
      cout << "stack 3: ";
      for (int i = start_index[2]; i < curr_index[2]; i++)
        cout << m_stack[i] << " ";
      cout << endl;

      cout << "total size: " << m_stack.size() << endl;
    }

    void print_start_indecies() {
      print_indecies("start indecies", start_index);
    }

    void print_end_indecies() {
      print_indecies("end indecies", end_index);
    }

    void print_curr_indecies() {
      print_indecies("curr indecies", curr_index);
    }

  private:
    vector<int> m_stack;
    vector<int> start_index;
    vector<int> end_index;
    vector<int> curr_index;
    int each_stack_size;


    void print_indecies(const string& opening, vector<int>& vec) {
      cout << opening << ": " << vec[0] << " " << vec[1] << " " << vec[2] << endl;
    }

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

void three_stack_test() {
  ThreeStack* my_stack = new ThreeStack();
  my_stack->print_stacks();

  int one = 0;
  int two = 1;
  int three = 2;
  my_stack->push(one, 1);
  my_stack->push(one, 12);
  my_stack->push(one, 11);
  my_stack->push(one, 21);
  
  my_stack->push(two, 12);
  my_stack->push(two, 102);
  my_stack->push(two,100);
  my_stack->push(two,10);

  my_stack->push(three, 10);

  my_stack->print_stacks();
  
  my_stack->pop(three);
  my_stack->pop(two);
  my_stack->pop(three);

  my_stack->print_stacks();
}

int main() {
  three_stack_test();
}

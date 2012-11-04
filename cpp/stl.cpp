#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <set>
#include <utility>
using namespace std;

typedef unsigned long evans_size_t;

// print_range<int>()  -->  "The range of int is [-21233120, 21231292]"
template <typename T> void print_range() {
  cout << "the range of " << typeid(T).name() << " is " << "[" << numeric_limits<T>::min() << " , " << numeric_limits<T>::max() << " ]" << endl;
}



void test_string() {
  string mina;
  cout << mina << endl;
  mina = "evan";
  cout << mina << endl;

  string evan = mina;
  evan.resize(2);
  cout << evan << " has size " << evan.size() << " and capacity " << evan.capacity() << endl;

  // TODO: write a for-loop that appends the character 'x' to string 'evan' 10 times.
  //       With each iteration, print the size and capacity of the string.
  for (int i = 0; i < 10; ++i) {
    evan.append("x");
    cout << "evan size: " << evan.size() << " capacity: " << evan.capacity() << endl;
  }
  cout << "max_size " << evan.max_size() << endl; 
  print_range<int>();
  print_range<size_t>();
}

int main(int argc, char** argv) {
  for (int i = 0; i < argc; i++) {
    cout << i << ") " << argv[i] << endl;
  }


  test_string();

}

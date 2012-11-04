#include <iostream>
#include<cmath>
#include <string>
using namespace std;


int sum_squares(int* arr) {
  int sum = 0;
  int total = sizeof(arr);
  cout << total << '\n';
  for (int i = 0 ; i < total; i++) {
    sum = arr[i] + sum;
  }

  return sum;
}

void print_random(int* arr) {
  cout << sizeof(arr) << "\n";
}

int main() 
{
  int A[2] = {1,2};

  int intArray[] = {1,2,3,4,5};
  int *ptrArr;
  ptrArr = intArray;

  cout << sum_squares(intArray);
  print_random(intArray);

  int myVar = 1;
  int *myPtr = &myVar;
  cout << *myPtr<< endl;

  *(myPtr++);
  cout << *myPtr << endl;

  cout << *myPtr << "\n";
  cout << myVar << "\n";
  *myPtr = 2;

  int x = 5;
  int& y = x;
  int m = x;

  set s1;
  set s2 = s1; // copy constructor:  set(const set& other)

  set s3;
  s3 = s1;  // assignment operator:  const set& operator=(const set& other);

  a = b = c;
  a.operator=(b.operator=(c));

  x++;
  y++;
  
  int* z;
  z = &x;
}

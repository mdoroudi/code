#include <iostream>
#include <vector>
#include <stdlib.h>
#include <stdio.h>

using namespace std;

void set_row_to_zero(vector< vector<int> >& matrix, int row_index);
void set_col_to_zero(vector< vector<int> >& matrix, int col_index);
void set_rows_cols_to_zero_v(vector<vector<int> >& matrix);
int rand_between(int first, int last);
template <typename T> void print_vector(vector<T>& vec);


template <typename T> void print_vector(vector<T>& vec) {
  for (int i = 0; i < vec.size(); i++) {
    cout << " " << vec[i] << " ";
  }

  cout << endl;
}

void set_rows_cols_to_zero_v(vector<vector<int> >& matrix) {
  vector<bool> rows_is_zero (matrix.size(), false);
  vector<bool> cols_is_zero (matrix[0].size(), false);

  for (int i = 0; i < matrix.size(); i++) {
    for (int j = 0; j < matrix[0].size(); j++) {
      if (matrix[i][j] == 0) {
        rows_is_zero[i] = true;
        cols_is_zero[j] = true;
      }
    }
  }


  for (int i = 0; i < rows_is_zero.size(); i++) {
    if (rows_is_zero[i] == true) 
      set_row_to_zero(matrix, i);
  }

  for (int i =0; i < cols_is_zero.size(); i++) {
    if (cols_is_zero[i] == true)
      set_col_to_zero(matrix, i);
  }

}

void my_swap(int* index_1, int* index_2) {
  int tmp = *index_1;
  *index_1 = *index_2;
  *index_2 = tmp;
}

void set_row_to_zero(vector< vector<int> >& matrix, int row_index) {
  for(int j = 0; j < matrix[0].size(); j++) {
    matrix[row_index][j] = 0;
  }
}

void set_col_to_zero(vector< vector<int> >& matrix, int col_index) {
  for (int i = 0; i < matrix.size(); i++) {
    matrix[i][col_index] = 0;
  }
}

void print_matrix(vector< vector<int> >& matrix) {
  for (int i = 0; i < matrix.size(); i++) {
    for (int j = 0; j < matrix[0].size(); j++) { 
      cout << " " << matrix[i][j] << " ";
    }
    cout << endl;
  }
}

vector< vector<int> > my_initialize(vector< vector<int> >& matrix) {
  for (int i = 0; i < matrix.size(); i++) {
    for (int j = 0; j < matrix[0].size(); j++) {
      matrix[i][j] = rand_between(0, 4);
    }
  }
  return matrix;
}

int rand_between(int first, int last) {
  int range_size = last - first + 1;
  return (rand()%range_size)+first;
}

class ScopeThing {
  public:
    ScopeThing() {
      cout << "ScopeThing created!" << endl;
    }
    ~ScopeThing() {
      cout << "ScopeThing destroyed!" << endl;
    }
};

void print_array_3x5(int arr[3][5]) {
  cout << "In print_array_3x5" << endl;
}

int main(int argc, char** argv) {
  int rows = 3;
  int cols = 5;
  int arr[3][5] = {{1,2,3,0,4}, {1,0,3,5,6}, {0,1,0,2,1}};

  vector<int> vec(3, 0);
  vector< vector<int> > matrix(4, vec);

  my_initialize(matrix);
  print_matrix(matrix);
  
  set_rows_cols_to_zero_v(matrix);
  print_matrix(matrix);

  int** evan = new int*[3];
  for(int i=0; i<3; ++i) {
    ScopeThing s;
    evan[i] = new int[5];
  }

  cout << typeid(arr).name() << endl;
  print_array_3x5(arr);

  
  int data[] = {2,3,4,5};
  vector<int> oneD (data, data+4);
  print_vector(oneD);
  my_swap(&oneD[1], &oneD[2]);
  print_vector(oneD);

}
  

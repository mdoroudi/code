#include <iostream>
#include <string>
using namespace std;

string merge(string& str1, string& str2) {
  string res = "";
  res.resize(str1.size()+str2.size());
  
  int i1 = 0;
  int i2 = 0;
  int s1 = str1.size();
  int s2 = str2.size();

  while (i1 < s1 && i2 < s2) {
    if (str1[i1] < str2[i2]) { 
      res[i1+i2] = str1[i1];
      i1++;
    }
    else {
      res[i1+i2] = str2[i2];
      i2++;
    }
  }

  if (i1 < s1) {
    while (i1 < s1) {
      res += str1[i1];
      i1++;
    }
  } else {
    while (i2 < s2) {
      res += str2[i2];
      i2++;
    }
  }
  return res;
}


string merge_sort(string& str) {
  if (str.size() == 0 || str.size() == 1)
    return str;
  
  int middle = str.size()/2; 
  string s1 = "";
  string s2 = "";

  for(int i = 0; i < middle; i++) {
    s1 += str[i];
  }
  
  for(int i = middle; i < str.size(); i++) {
    s2 += str[i];
  }

  s1 = merge_sort(s1);
  s2 = merge_sort(s2);

  if (s1[s1.size()-1] < s2[0])
    return s1+s2;
  else
    return merge(s1, s2);
}

string quick_sort(string& str) {
  if (str.size() == 0 || str.size() == 1)
    return str;

  int middle = str.size()/2;
  char piv = str[middle];

  string s1 = "";
  string s2 = "";

  for (int i = 0; i < str.size(); i++) {
    if (i != middle) {
      if (piv < str[i])
        s2 += str[i];
      else
        s1 += str[i];
    }
  }
  
  return quick_sort(s1)+piv+quick_sort(s2);
}

bool are_anagrams(string s1, string s2) {
  string s1_sorted = quick_sort(s1);
  string s2_sorted = quick_sort(s2);

  if (s1_sorted == s2_sorted)
    return true;
  else
    return false;
}

bool all_unique_chars(string str) {
  if (str.size() == 1 || str.size() == 0)
    return false;

  for (int i = 0; i < str.size(); i++) {
    for (int j = i+1; j < str.size(); j++) {
      if (str[i] == str[j]) {
        return true;
      }
    }
  }
  return false;
}

void shift_down(string& str, int replace_i) {
  for (int i = replace_i; i < str.size(); i++ ) {
    str[i] = str[i+1];
  } 
}

void remove_duplicates_inefficient(string& str) {
  if (str.size() == 0 || str.size() == 1)
    return;
  int shifted = 0;
  
  for (int i = 0; i < str.size(); i++) {
    int j = i+1;
    while (j < (str.size() - shifted)) {
      if (str[i] == str[j]) {
        shift_down(str, i);
        shifted++;
      }
      else { 
        j++;
      }
    }
  }
  str.resize(str.size() - shifted);
}

void remove_duplicates(string& str) {
  if (str.size() == 0 || str.size() == 1) {
    return; 
  }

  string res = "";

  for (int i = 1; i < str.size(); i++) {
    bool is_dup = false;
    for (int j = i - 1; j >= 0; j--) {
      if (str[i] == str[j]) {
        is_dup = true;
        break;
      } 
    }
    
    if (is_dup == false) {
      res += str[i];
    }
  }
  str = str[0]+res;
  return;
}

void swap_chars(string& str, int i, int j) {
  char tmp = str[i];
  str[i] = str[j];
  str[j] = tmp;
}



void reverse(string& str) {
  int i = 0;
  int j = str.size() - 1;
  
  while (i < j) {
    swap_chars(str, i, j);
    j--;
    i++;
  }
}

int main(int argc, char** argv) {
  //string m = "mina";
  //cout << m.size() << endl;
  //cout << all_unique_chars(argv[1]) << endl;
  //cout << m << endl;
  //reverse(m);
  //cout << m << endl;
  cout << "hello world" << endl;
  string str = "minamooinaz";
  cout << str << endl;
  remove_duplicates(str);
  cout << str << endl;

  str = "minamooinaz";

  cout << "sorting string: "<< str << endl; 
  cout << merge_sort(str) << endl;
  cout << "sorting string: " << str << endl;
  cout << quick_sort(str) << endl;

  cout << are_anagrams("aina", "amin") << endl;
}

#include <iostream>
using namespace std;

void pointer() {
  int angka = 10;
  int* ptr = &angka;

  cout << angka << endl; //nilai
  cout << &angka << endl; //alamat
  cout << ptr << endl; //isi
  cout << &ptr << endl; //alamat

  *ptr = 25;
  cout << angka << endl; //nilai after
}

int main() {
  pointer();
}

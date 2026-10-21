#include <iostream>
#include <conio.h>

using namespace std;

int main () {
  char A[10];
  int depan, belakang;
  int cek;
  int z;
  depan = 0;
    belakang = -1;
    do {
      system("cls");
      cout << "1. Tambah data stack\n";
      cout << "2. Tampilan data\n";
      cout << "3. Hapus isi stack\n";
      cout << "4. Keluar Program\n";
      cout << "Pilihan :";
      cek = getche();
      cout << endl;

      if (cek == '1') {
        if (belakang == 9) {
          cout << "Stack penuh!\n";
        } else {
          belakang++;
          cout << "Masukkan data :";
          cin >> A[belakang];
        }
        getch();
      } else if (cek == '2') {
        if (belakang < depan) {
          cout << "Stack kosong!\n";
        } else {
          cout << "Isi stack :\n";
          for (z = belakang; z >= depan; z--) {
            cout << A[z] << endl;
          }
        }
        getch();
      } else if (cek == '3') {
        if (belakang < depan) {
          cout << "Stack kosong!\n";
        } else {
          cout << "Data yang dihapus :" << A[belakang] << endl;
          belakang--;
        }
        getch();
      }
    } while (cek != '4');

  return 0;
}

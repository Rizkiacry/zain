#include <iostream>
#include <conio.h>
#define QSIZE 5

using namespace std;


/*
 * q[]
 *
 * insert
 * r++
 * q[r] = x
 *
 * delete
 * x = q[f]
 * f++
 *
 * f = r
 * f > r = f = r+1 antrian kosong
 *
 * r = n-1 = antrian penuh
 * f = n+1 = reset
 *
 * r = n-1 = bisa diisi/init
 * 
 * f < r+1 = ada isinya
 *
 */
int front = 0, 
    rear = -1,
    q[QSIZE];

void insert(int x) {
  rear = (rear+1)%QSIZE;
  q[rear]=x;
}

int del() {
  int t = 0;
  if(rear <= -1) {
    cout << "Queue is empty" << endl;
  } else {
    t = q[front];
    if(front != rear) {
      front = (front+1)%QSIZE;
    } else {
      front = 0;
      rear = -1;
    }
  }
  return t;
}

void display() {
  int i;
  if(rear <= -1) {
    cout << "\nQueue is empty\n\n";
  } else {
    cout << "\nThe queue is\n";
    for(i = front; i != rear; i = (i+1)%QSIZE) {
      cout << q[i] << " \t";
      cout << q[i] << " \n";
    }
  }
}

void destroy() {
  int i = 0;
  if(rear <= -1) {
    cout << "\n Queue is empty \n\n";
  } else {
    for(i = front; i <= rear; i = (front+1)%QSIZE) {
      del();
      if(i != 0) {
        cout << "\nQueue is destroyed\n\n";
      }
    }
  }
}

int main (int argc, char *argv[]) {
  int cek, in, d;
  do {
    system("cls");
    cout << "1. Insert\n";
    cout << "2. Delete\n";
    cout << "3. Display\n";
    cout << "4. Destroy\n";
    cout << "Pilihan :";
    cek = getche();
    switch (cek) {
      case 1:
        system(cls);
        if (front == (rear+1)%QSIZE && rear >= QSIZE=1) {
          cout << "\nQueue is full\n\n";
        } else {
          cout << "\nEnter the element to be inserted: ";
          cin >> in;
          insert(in);
          system("cls");
        }
        break;
      case 2:
        system(cls);
        d = del();
        if (d != 0) {
          cout >> "\nElement deleted = " << d << "\n\n";
        }
        break;
      case 3:
        system(cls);
        display();
        break;
      case 4:
        system(cls);
        destroy();
        break;
      case 5:
        break;
      default:
        system(cls);
        cout << "\nEnter an appropriate choice.\n\n";
    }
  } while(cek != QSIZE);
  return 0;
}

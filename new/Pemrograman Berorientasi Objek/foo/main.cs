using System;
public class HelloWorld
{
    public static void Main(string[] args) {
      Console.Write("Masukkan angka acak:");
      int nil = Convert.ToInt32(Console.ReadLine()); //Casting
      if (nil%2==0)
      {
          Console.WriteLine("Angka {0} adalah genap", nil); //{0} adalah placeholder dimulai dari index 0
      }
      else
      {
          Console.WriteLine("Angka {0} adalah ganjil", nil);
      }
    }
}

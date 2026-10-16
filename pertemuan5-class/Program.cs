// don't repeat yourself
//
// class = car
// object = volvo
//
// class diagram
// class = attribute + method
// attribute = breed, size, age
// method = eat(), sleep()
//
// class is a template for object
// object can't be created before class
// 
// method constructor = dipanggil saat dibuat
//
//

// class Car {
//   public string color = "red";
//   static void Main(string[] args) {
//     Car myobj1 = new Car();
//     Car myobj2 = new Car();
//     Console.WriteLine(myobj1.color);
//     Console.WriteLine(myobj2.color);
//   }
// }


class Program
{
    static void Main(string[] args)
    {
      // Pegawai p1 = new Pegawai();
      // p1.nama = "Zain";
      // p1.alamat = "Jawa";
      // p1.jeniskel = "L";
      // p1.umur = 39;
      //
      // Console.WriteLine("Nama:{0}\nAlamat:{1}\nJenis Kelamin:{2}\nUmur:{3}", p1.nama, p1.alamat, p1.jeniskel, p1.umur);
      //
      Pegawai p = new Pegawai();
      tampilpegawai(p);

      Persegi ps = new Persegi();
      tampilpersegi(ps);
    }
    public static void tampilpegawai(Pegawai p)
    {
      Console.Write("Masukkan Nama:");
      p.nama = Console.ReadLine();
      Console.Write("Masukkan Alamat:");
      p.alamat = Console.ReadLine();
      Console.Write("Masukkan Jenis Kelamin:");
      p.jeniskel = Console.ReadLine();
      Console.Write("Masukkan Umur:");
      p.umur = Convert.ToInt16(Console.ReadLine());
      Console.Write("Masukkan Jumlah Hari Kerja:");
      double x = Convert.ToDouble(Console.ReadLine());
      Console.Write("Masukkan Gaji Harian:");
      double y = Convert.ToDouble(Console.ReadLine());
      Console.WriteLine("Nama:{0}\nAlamat:{1}\nJenis Kelamin:{2}\nUmur:{3}", p.nama, p.alamat, p.jeniskel, p.umur);
      Console.Write("Gaji anda adalah: {0}\n", p.hitgaji(x, y));
    }

    public static void tampilpersegi(Persegi ps)
    {
      Console.Write("Masukkan Panjang Sisi:");
      ps.sisi = Convert.ToDouble(Console.ReadLine());
      Console.WriteLine("Keliling Persegi: {0}\nLuas Persegi: {1}", ps.keliling(ps.sisi), ps.luas(ps.sisi));
    }
}

class Persegi
{
  public double sisi;
  public double keliling(double s)
  {
    return 4 * s;
  }
  public double luas(double s)
  {
    return s * s;
  }
}

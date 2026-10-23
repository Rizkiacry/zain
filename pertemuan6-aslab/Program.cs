class Program
{
  static void Main(string[] args)
  {
    //make new object with Persegi() template
    Persegi ps = new Persegi();
    PersegiPanjang psp = new PersegiPanjang();
    tampilpersegi(ps);
    tampilpersegipanjang(psp);
  }

  //method + static
  public static void tampilpersegi(Persegi ps)
  {
    Console.Write("Masukkan panjang sisi: ");
    //parameter/object
    ps.sisi = Convert.ToDouble(Console.ReadLine());
    Console.WriteLine("Keliling Persegi: {0}\nLuas Persegi: {1}", ps.Keliling(ps.sisi), ps.Luas(ps.sisi));
  }

  public static void tampilpersegipanjang(PersegiPanjang psp)
  {
    Console.Write("Masukkan panjang: ");
    psp.panjang = Convert.ToDouble(Console.ReadLine());
    Console.Write("Masukkan lebar: ");
    psp.lebar = Convert.ToDouble(Console.ReadLine());
    Console.WriteLine("Keliling Persegi Panjang: {0}\nLuas Persegi Panjang: {1}", psp.Keliling(psp.panjang, psp.lebar), psp.Luas(psp.panjang, psp.lebar));
  }
}

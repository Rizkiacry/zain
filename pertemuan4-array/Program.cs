using System;

namespace ConsoleApp3
{
    internal class Program
    {
        public static double nAkhir;
        static void Main(string[] args)
        {
            // double nKehadiran, nTugas, nUTS, nUAS;
            double[] nilai;
            nilai = new double[4];
            for (int i = 0; i < nilai.Length; i++)
            {
                Console.Write("Masukkan nilai ke-{0}: ", i + 1);
                nilai[i] = Convert.ToDouble(Console.ReadLine());
            }

            foreach (double j in nilai)
            {
                Console.WriteLine(j);
            }

            hitNilai(nilai[0], nilai[1], nilai[2], nilai[3]);
            string YN;

            do
            {
                Console.Write("Masukkan nilai kehadiran: ");
                nKehadiran = Convert.ToDouble(Console.ReadLine());
                Console.Write("Masukkan nilai tugas: ");
                nTugas = Convert.ToDouble(Console.ReadLine());
                Console.Write("Masukkan nilai UTS: ");
                nUTS = Convert.ToDouble(Console.ReadLine());
                Console.Write("Masukkan nilai UAS: ");
                nUAS = Convert.ToDouble(Console.ReadLine());

                hitNilai(nKehadiran, nTugas, nUTS, nUAS);
                Console.Write("Apakah mau menghitung nilai lainnya Y/T: ");
                YN = (Console.ReadLine() ?? "").ToUpper();
            } while (YN == "Y");
        } public static void hitNilai(double n1, double n2, double n3, double n4) {
            double nAkhir = (n1 * 0.1) + (n2 * 0.2) + (n3 * 0.3) + (n4 * 0.4);
            Console.WriteLine("Nilai akhir anda adalah: {0}", nAkhir);
        }
    }
}

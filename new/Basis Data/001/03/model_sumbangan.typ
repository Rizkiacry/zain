// Mini Modeling Lab — Pertemuan 3 — Model Sumbangan
// Compile: typst compile model_sumbangan.typ

#set page(
  paper: "a4",
  margin: (x: 1.3cm, y: 1.2cm),
)
#set text(font: "Libertinus Serif", size: 9.3pt)
#set par(justify: true, leading: 0.42em)
#set list(indent: 0.5em, body-indent: 0.35em)
#set enum(indent: 0.6em, body-indent: 0.35em)

#let num(n) = box(
  fill: rgb("#1f3a5f"), inset: 3.5pt, radius: 50%, outset: 2pt,
  text(fill: white, size: 8pt, weight: "bold", str(n)),
)
#let sect(n, title, en) = block(
  above: 0.7em, below: 0.3em,
  [#num(n) #h(3pt) *#title* #text(size: 8.2pt, style: "italic", fill: rgb("#5a6472"), en)],
)
#let rel(body) = text(weight: "bold", size: 8.6pt, body)

// ---------- Header ----------
#block(
  fill: rgb("#1f3a5f"), inset: 7pt, radius: 3pt, width: 100%,
  text(fill: white)[
    #text(size: 13pt, weight: "bold")[Mini Modeling Lab — Pertemuan 3] #h(1fr)
    #text(size: 8pt)[Basis Data OBE • C31020303 • 1 halaman]
    #v(-2pt)
    #text(size: 9.6pt, style: "italic")[Model Sumbangan — dari narasi kebutuhan → model konseptual → draft model logis awal]
  ],
)

// ---------- 1. Ruang Lingkup ----------
#sect(1, "Ruang Lingkup", "needs narrative — 4–6 kalimat")
Sistem yang dimodelkan adalah *Sistem Sumbangan*: layanan pencatatan sumbangan kas dari donatur untuk program kegiatan sebuah lembaga (yayasan / RT / masjid / organisasi kemahasiswaan). *Scope*-nya sederhana — donatur memberi sumbangan, pengurus mencatat dan *verify* setiap transaksi masuk, lalu menerbitkan kuitansi sebagai bukti. Setiap sumbangan ditujukan ke satu #emph[program/dana] (mis. dana duka, renovasi aula, kas kegiatan), sehingga sistem dapat menghasilkan laporan kas per periode: total masuk, total keluar, dan saldo. Saat ini pencatatan masih manual pada buku kas sehingga rawan *redundancy* — nama donatur ditulis berulang di banyak lembar dan rekap bulanan lambat serta mudah salah. *Insight from web research*: best practice perancangan sistem donasi menekankan *separation of identity and transaction* — identitas donatur cukup disimpan sekali pada relation donatur, sedangkan tiap sumbangan hanya menyimpan penghubung `id_donatur` beserta nominal, tanggal, dan status verifikasi.

// ---------- 2. Objek Penting ----------
#sect(2, "Objek Penting", "calon objek/entitas dari kata benda penting")
- *DONATUR* — pihak pemberi sumbangan; identitasnya dipakai berulang, layak jadi entitas utama.
- *SUMBANGAN* — transaksi penerimaan kas; record bisnis inti (satu baris = satu peristiwa sumbangan).
- *PROGRAM_SUMBANGAN* — dana/kegiatan tujuan sumbangan; mencegah alokasi dana tercampur.
- *PENGGUNAAN_DANA* — catatan pengeluaran dari suatu program agar laporan kas seimbang.
- *Bukan entitas terpisah*: kuitansi (cukup nomor field pada SUMBANGAN) dan pengurus (di luar scope halaman ini).

// ---------- 3. Fakta & Hubungan ----------
#sect(3, "Fakta & Hubungan", "business sentences")
+ Donatur memberikan sumbangan.
+ Sumbangan ditujukan untuk program sumbangan tertentu.
+ Pengurus mencatat dan memverifikasi setiap sumbangan masuk.
+ Pengurus menerbitkan kuitansi untuk sumbangan yang sudah terverifikasi.
+ Pengurus mencatat pengeluaran dana dari program sumbangan.
+ Donatur dapat meminta identitasnya tidak dipublikasikan pada laporan (*anonymous per-transaksi*).

// ---------- 4. Draft Relation ----------
#sect(4, "Draft Relation", "relation awal + field utama + makna fakta")
#set table(
  inset: 3.5pt, stroke: 0.4pt + rgb("#9aa4b2"),
  align: (left, left, left), fill: (_, y) => if y == 0 { rgb("#e8edf4") },
)
#table(
  columns: (auto, 1fr, auto),
  table.header([*Relation (draft)*, *Field utama*, *Makna fakta ↔ kalimat bisnis*]),
  [#rel[DONATUR]\ #(text(size: 8pt)[(id_donatur, nama, no_hp, email, is_anonim)])],
  [id_donatur],
  [Kalimat 1, 6 — data pemberi sumbangan, disimpan sekali],
  [#rel[PROGRAM_SUMBANGAN]\ #(text(size: 8pt)[(id_program, nama_program, target_dana)])],
  [id_program],
  [Kalimat 2 — daftar tujuan/penempatan sumbangan],
  [#rel[SUMBANGAN]\ #(text(size: 8pt)[(id_sumbangan, id_donatur, id_program, tanggal, nominal, metode, status_verifikasi, nomor_kuitansi)])],
  [id_sumbangan],
  [Kalimat 1, 2, 3, 4, 6 — transaksi + verifikasi + kuitansi + anonim],
  [#rel[PENGGUNAAN_DANA]\ #(text(size: 8pt)[(id_pengeluaran, id_program, tanggal, nominal, keterangan)]),
  ],
  [id_pengeluaran],
  [Kalimat 5 — pengeluaran kas dari suatu program],
)
#v(1pt)
#text(size: 8.2pt, style: "italic")[Catatan: field utama ditulis informal sebagai id; penerapan key & constraint formal dibahas pada Pertemuan 4–5. Semua relation dapat ditelusuri kembali ke kalimat kebutuhan (no orphan relation).]

// ---------- 5. Domain Awal ----------
#sect(5, "Domain Awal", "contoh nilai sah untuk field penting")
#table(
  columns: (auto, auto, 1fr),
  inset: 3.5pt, stroke: 0.4pt + rgb("#9aa4b2"),
  fill: (_, y) => if y == 0 { rgb("#e8edf4") },
  [*Field*, *Contoh nilai sah*, *Domain / aturan*],
  [`nominal`], [`50000`, `150000`, `1000000`], [bilangan bulat rupiah, > 0 (bukan teks)],
  [`status_verifikasi`], [`menunggu`, `terverifikasi`, `ditolak`], [pick-list; salah satu nilai saja],
  [`metode`], [`tunai`, `transfer_bank`, `qris`, `ewallet`], [pick-list; format & pilihan dibatasi aturan bisnis],
)

// ---------- 6. Validasi ----------
#sect(6, "Validasi", "setiap relation dapat dijelaskan kembali dari kebutuhan")
#text(size: 8.9pt)[
  #h(1em)DONATUR ↔ kal. 1, 6 ✓ #h(1em)PROGRAM_SUMBANGAN ↔ kal. 2 ✓ #h(1em)SUMBANGAN ↔ kal. 1, 2, 3, 4, 6 ✓ #h(1em)PENGGUNAAN_DANA ↔ kal. 5 ✓
]
#v(1pt)
#text(size: 8.9pt)[Setiap *business sentence* didukung minimal satu relation, dan setiap relation punya kalimat asalnya → tidak ada fakta tanpa rumah. *Cardinality relation* (jumlah record): DONATUR & PROGRAM sedikit (puluhan), SUMBANGAN & PENGGUNAAN_DANA banyak (ratusan–ribuan) — itulah alasan pemisahan relation, bukan formalisme hubungan. Keputusan yang *belum* dibahas: tipe data DBMS, index, storage (model fisik).]

// ---------- Footer ----------
#v(1fr)
#block(
  inset: 5pt, radius: 3pt, stroke: 0.5pt + rgb("#1f3a5f"), width: 100%,
  text(size: 8.2pt)[
    *Format jawaban:* narasi kebutuhan + objek penting + hubungan + draft relation/field + domain awal — sesuai Mini Modeling Lab Pertemuan 3.
    #h(1fr) Istilah: field = #emph[attribute], record = #emph[tuple]; #emph[cardinality] di sini = jumlah record.
  ],
)

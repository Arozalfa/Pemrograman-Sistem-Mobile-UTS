// ============================================================================
// UJIAN TENGAH SEMESTER (UTS) GANJIL 2026/2027
// Mata Kuliah    : Pemrograman Mobile
// Dosen Pengampu : Royan Habibie Sukarna
//
// Identitas Mahasiswa:
// Nama           : Abdul Rozaq Al Fauzan
// NIM            : 3337240079
// Program Studi  : Informatika
// Fakultas       : Teknik
// Universitas    : Universitas Sultan Ageng Tirtayasa (UNTIRTA)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const KantinApp());
}

class KantinApp extends StatelessWidget {
  const KantinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kantin Untirta - Abdul Rozaq Al Fauzan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      ),
      home: const MenuListPage(),
    );
  }
}

// ============================================================================
// SOAL 1 – CUSTOM WIDGET TEKS REUSABLE (20 poin)
// ============================================================================
// Komentar Alasan Desain:
// Menggunakan font Poppins dari Google Fonts karena memiliki gaya tipografi modern,
// proporsi geometris yang bersih, serta tingkat keterbacaan (readability) yang sangat baik pada layar smartphone.
// Palet warna warm orange/deep orange dipadukan dengan variasi ketebalan teks fleksibel guna menciptakan
// hierarki visual yang jelas dan menarik antara judul halaman, nama menu, serta nominal harga makanan.
class KantinText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const KantinText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

// Fungsi pembantu untuk memformat integer nominal menjadi format mata uang Rupiah
String formatRupiah(int price) {
  final priceString = price.toString();
  final formatted = priceString.replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]}.',
  );
  return 'Rp $formatted';
}

// ============================================================================
// SOAL 2 – HALAMAN DAFTAR MENU (45 poin)
// Sesuai Gambar 1:
// Scaffold
// ├── appBar: AppBar -> Text (KantinText)
// ├── body: Column
// │   ├── Padding -> Text (KantinText)
// │   └── Expanded -> ListView.builder -> Card -> ListTile
// │       ├── leading: Icon
// │       ├── title: Text (KantinText)
// │       ├── subtitle: Text (KantinText)
// │       └── trailing: Icon
// └── floatingActionButton: FloatingActionButton -> Icon
// ============================================================================
class MenuListPage extends StatefulWidget {
  const MenuListPage({super.key});

  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  // Data menu (nama dan harga) disimpan dalam List biasa di dalam State, minimal 5 data awal
  final List<Map<String, dynamic>> menuList = [
    {
      'nama': 'Nasi Goreng Spesial Untirta',
      'harga': 15000,
      'deskripsi':
          'Nasi goreng dengan suwiran ayam gurih, telur mata sapi, acar segar, dan kerupuk renyah khas kantin kampus.',
    },
    {
      'nama': 'Ayam Geprek Sambal Bawang',
      'harga': 13000,
      'deskripsi':
          'Ayam krispi renyah digeprek dengan sambal cabai rawit bawang pedas gurih disajikan hangat dengan lalapan.',
    },
    {
      'nama': 'Mie Ayam Bakso Cilegon',
      'harga': 12000,
      'deskripsi':
          'Mie kenyal dipadu potongan daging ayam bumbu semur manis gurih, sawi segar, dan 2 butir bakso sapi empuk.',
    },
    {
      'nama': 'Soto Ayam Lamongan',
      'harga': 14000,
      'deskripsi':
          'Soto ayam hangat dengan kuah kuning rempah istimewa, suwiran ayam, bihun, koya gurih, dan sambal pedas.',
    },
    {
      'nama': 'Es Teh Manis Jumbo',
      'harga': 5000,
      'deskripsi':
          'Minuman es teh melati manis dingin porsi jumbo penghilang rasa dahaga mahasiswa setelah kuliah.',
    },
    {
      'nama': 'Jus Alpukat Cokelat',
      'harga': 10000,
      'deskripsi':
          'Jus buah alpukat segar pilihan bertekstur kental dengan lumuran susu kental manis cokelat premium.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const KantinText(
          'Kantin FT Untirta',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: const KantinText(
              'Daftar Pilihan Menu Makanan & Minuman',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                final item = menuList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 6.0,
                  ),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.fastfood,
                      color: Colors.deepOrange,
                      size: 28,
                    ),
                    title: KantinText(
                      item['nama'] as String,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    subtitle: KantinText(
                      formatRupiah(item['harga'] as int),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepOrange.shade800,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // Buka halaman detail yang menampilkan nama dan harga menu menggunakan Get.to()
                      Get.to(() => MenuDetailPage(
                            nama: item['nama'] as String,
                            harga: item['harga'] as int,
                            deskripsi: item['deskripsi'] as String? ??
                                'Menu pilihan kantin kampus.',
                          ));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Tombol FloatingActionButton membuka halaman tambah menu menggunakan Get.to()
          final result = await Get.to(() => const AddMenuPage());
          // Halaman daftar menerima hasil tersebut, menambahkannya ke List, dan memperbarui tampilan dengan setState
          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              menuList.add(result);
            });
          }
        },
        backgroundColor: Colors.deepOrange,
        tooltip: 'Tambah Menu Baru',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ============================================================================
// SOAL 3 – HALAMAN TAMBAH MENU (35 poin)
// Sesuai Gambar 2:
// Scaffold
// ├── appBar: AppBar -> Text (KantinText)
// └── body: Padding
//     └── Form
//         └── Column
//             ├── TextFormField
//             ├── SizedBox
//             ├── TextFormField
//             ├── SizedBox
//             └── ElevatedButton -> Text (KantinText)
// ============================================================================
class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _simpanMenu() {
    if (_formKey.currentState!.validate()) {
      final newMenu = {
        'nama': _namaController.text.trim(),
        'harga': int.parse(_hargaController.text.trim()),
        'deskripsi': 'Menu lezat yang baru ditambahkan ke kantin kampus.',
      };
      // Jika semua valid, data menu baru dikirim kembali ke halaman daftar menggunakan Get.back(result: ...)
      Get.back(result: newMenu);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const KantinText(
          'Tambah Menu Baru',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Menu',
                  hintText: 'Contoh: Batagor Kuah',
                  prefixIcon: Icon(Icons.restaurant, color: Colors.deepOrange),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                  ),
                ),
                validator: (value) {
                  // Kolom nama tidak boleh kosong
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama menu tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga Menu (Rp)',
                  hintText: 'Contoh: 12000',
                  prefixIcon: Icon(Icons.monetization_on, color: Colors.deepOrange),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                  ),
                ),
                validator: (value) {
                  // Kolom harga tidak boleh kosong dan hanya menerima angka
                  if (value == null || value.trim().isEmpty) {
                    return 'Harga menu tidak boleh kosong';
                  }
                  final parsed = int.tryParse(value.trim());
                  if (parsed == null) {
                    return 'Harga hanya menerima angka';
                  }
                  if (parsed <= 0) {
                    return 'Harga harus lebih besar dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _simpanMenu,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const KantinText(
                  'Simpan Menu',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// HALAMAN DETAIL MENU (Struktur bebas, menampilkan nama dan harga, bisa kembali)
// ============================================================================
class MenuDetailPage extends StatelessWidget {
  final String nama;
  final int harga;
  final String deskripsi;

  const MenuDetailPage({
    super.key,
    required this.nama,
    required this.harga,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const KantinText(
          'Detail Menu Kantin',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.restaurant_menu,
                          size: 72,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    KantinText(
                      nama,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
                    KantinText(
                      formatRupiah(harga),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                      textAlign: TextAlign.center,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(),
                    ),
                    const KantinText(
                      'Deskripsi Menu:',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    const SizedBox(height: 6.0),
                    KantinText(
                      deskripsi,
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Card(
              color: Colors.orange.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    const Icon(Icons.school, color: Colors.deepOrange),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          KantinText(
                            'Kantin Fakultas Teknik Untirta',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          KantinText(
                            'Praktikan: Abdul Rozaq Al Fauzan (3337240079)',
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back),
                label: const KantinText(
                  'Kembali ke Daftar Menu',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

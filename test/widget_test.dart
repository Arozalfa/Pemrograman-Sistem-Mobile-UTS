// ============================================================================
// WIDGET TESTS - KANTIN APP
// Mahasiswa: Abdul Rozaq Al Fauzan (NIM: 3337240079)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kantin_app/main.dart';

void main() {
  testWidgets('Memverifikasi halaman daftar menu dan custom text widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(const KantinApp());
    await tester.pumpAndSettle();

    // Verifikasi AppBar menampilkan judul dengan KantinText
    expect(find.text('Kantin FT Untirta'), findsOneWidget);
    expect(find.byType(KantinText), findsWidgets);

    // Verifikasi data awal minimal 5 menu tampil di daftar
    expect(find.text('Nasi Goreng Spesial Untirta'), findsOneWidget);
    expect(find.text('Ayam Geprek Sambal Bawang'), findsOneWidget);
    expect(find.text('Mie Ayam Bakso Cilegon'), findsOneWidget);
    expect(find.text('Soto Ayam Lamongan'), findsOneWidget);
    expect(find.text('Es Teh Manis Jumbo'), findsOneWidget);

    // Verifikasi FloatingActionButton dengan ikon tambah ada
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Verifikasi validasi form tambah menu jika kosong atau non-angka',
      (WidgetTester tester) async {
    await tester.pumpWidget(const KantinApp());
    await tester.pumpAndSettle();

    // Tekan tombol FloatingActionButton untuk membuka form tambah menu
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Verifikasi berada di halaman Tambah Menu
    expect(find.text('Tambah Menu Baru'), findsOneWidget);
    expect(find.text('Simpan Menu'), findsOneWidget);

    // Tekan tombol Simpan tanpa mengisi form (uji validasi kosong)
    await tester.tap(find.text('Simpan Menu'));
    await tester.pumpAndSettle();

    expect(find.text('Nama menu tidak boleh kosong'), findsOneWidget);
    expect(find.text('Harga menu tidak boleh kosong'), findsOneWidget);

    // Masukkan nama yang valid dan harga non-angka
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Nama Menu'), 'Batagor Bandung');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Harga Menu (Rp)'), 'bukan_angka');
    await tester.tap(find.text('Simpan Menu'));
    await tester.pumpAndSettle();

    expect(find.text('Harga hanya menerima angka'), findsOneWidget);

    // Masukkan harga yang valid
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Harga Menu (Rp)'), '18000');
    await tester.tap(find.text('Simpan Menu'));
    await tester.pumpAndSettle();

    // Verifikasi kembali ke halaman daftar
    expect(find.text('Kantin FT Untirta'), findsOneWidget);

    // Scroll pada ListView agar item baru yang berada di bawah terlihat
    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();

    // Verifikasi menu baru berhasil ditambahkan dan tampil
    expect(find.text('Batagor Bandung'), findsOneWidget);
    expect(find.text('Rp 18.000'), findsOneWidget);
  });

  testWidgets('Verifikasi navigasi ke Halaman Detail Menu dan kembali ke daftar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const KantinApp());
    await tester.pumpAndSettle();

    // Klik item pertama pada daftar
    await tester.tap(find.text('Nasi Goreng Spesial Untirta'));
    await tester.pumpAndSettle();

    // Verifikasi berada di halaman detail menu
    expect(find.text('Detail Menu Kantin'), findsOneWidget);
    expect(find.text('Nasi Goreng Spesial Untirta'), findsOneWidget);
    expect(find.text('Rp 15.000'), findsOneWidget);
    expect(find.text('Deskripsi Menu:'), findsOneWidget);

    // Tekan tombol kembali (IconButton pada AppBar)
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    // Verifikasi kembali ke halaman utama
    expect(find.text('Kantin FT Untirta'), findsOneWidget);
  });
}

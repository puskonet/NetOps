import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Warna Utama (Professional Blue)
  static const Color primaryColor = Color(0xFF0D47A1); // Biru Gelap
  static const Color secondaryColor = Color(0xFF2196F3); // Biru Terang
  static const Color accentColor = Color(0xFFFFC107); // Kuning Peringatan
  static const Color backgroundColor = Color(0xFFF3F4F6); // Abu-abu sangat muda
  static const Color cardColor = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,

      // Konfigurasi Warna
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        surface: backgroundColor,
      ),

      // Font Style
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        bodyMedium: GoogleFonts.inter(fontSize: 14, color: Colors.black54),
        labelSmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),

      // PERBAIKAN DI SINI:
      // Ganti 'CardTheme' menjadi 'CardThemeData'
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ).data, // <-- TRIK: Jika SDK meminta CardThemeData, kita bisa ambil property .data atau gunakan Constructor CardThemeData() langsung jika tersedia.
      // OPSI ALTERNATIF (Jika kode di atas masih merah):
      // Hapus bagian .data di atas, dan ganti nama kelasnya langsung:
      /*
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),
      */

      // AppBar Style
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'injection_container.dart' as di;
import 'core/theme/app_theme.dart';

// Import Splash Screen
import 'features/auth/presentation/pages/splash_screen.dart';

void main() {
  // Pastikan binding siap
  WidgetsFlutterBinding.ensureInitialized();

  // Setup Database FFI untuk Desktop (Aman ditaruh di sini karena ringan)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // LANGSUNG jalankan AppStarter tanpa menunggu apapun
  runApp(const AppStarter());
}

/// Widget khusus untuk mengatur status inisialisasi aplikasi
/// Ini menjamin UI Loading muncul DULUAN sebelum proses berat dimulai.
class AppStarter extends StatefulWidget {
  const AppStarter({super.key});

  @override
  State<AppStarter> createState() => _AppStarterState();
}

class _AppStarterState extends State<AppStarter> {
  // Status aplikasi: 0=Loading, 1=Sukses, 2=Error
  int _appState = 0;
  Object? _error;
  StackTrace? _stackTrace;

  @override
  void initState() {
    super.initState();
    // Panggil inisialisasi setelah frame pertama selesai dirender
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    try {
      // --- MULAI PROSES BERAT DI SINI ---

      // Beri sedikit jeda agar animasi loading sempat berputar (terlihat lebih mulus)
      await Future.delayed(const Duration(milliseconds: 500));

      // Inisialisasi Service Locator (GetIt)
      await di.init();

      // Jika berhasil, ubah state ke Sukses
      if (mounted) {
        setState(() {
          _appState = 1;
        });
      }
    } catch (e, stack) {
      // Jika gagal, tangkap errornya
      debugPrint("FATAL ERROR: $e");
      if (mounted) {
        setState(() {
          _error = e;
          _stackTrace = stack;
          _appState = 2;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Logika pemilihan tampilan berdasarkan state
    if (_appState == 1) {
      // STATE 1: SUKSES -> Masuk ke Aplikasi Utama
      return const NetOpsApp();
    } else if (_appState == 2) {
      // STATE 2: ERROR -> Tampilkan Layar Error
      return ErrorApp(error: _error!, stackTrace: _stackTrace!);
    } else {
      // STATE 0: LOADING -> Tampilkan Bootstrap/Loading Screen
      return const BootstrapApp();
    }
  }
}

class NetOpsApp extends StatelessWidget {
  const NetOpsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetOps Mobile',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

// --- WIDGET 1: BOOTSTRAP (LOADING AWAL) ---
class BootstrapApp extends StatelessWidget {
  const BootstrapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Menggunakan CircularProgressIndicator
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              const SizedBox(height: 24),
              Text(
                "Menyiapkan Aplikasi...",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Mohon tunggu sebentar",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- WIDGET 2: ERROR SCREEN ---
class ErrorApp extends StatelessWidget {
  final Object error;
  final StackTrace stackTrace;

  const ErrorApp({super.key, required this.error, required this.stackTrace});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red.shade50,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_off_rounded,
                      size: 80,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Gagal Memulai Aplikasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Terjadi kesalahan saat proses inisialisasi sistem.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.shade200),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.red.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Detail Error:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            error.toString(),
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Restart app logic sederhana (hanya reload UI init)
                        // Dalam production mungkin perlu exit(0) atau restart full
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const AppStarter()),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text("Coba Lagi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

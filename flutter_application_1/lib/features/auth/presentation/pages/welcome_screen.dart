import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import login screen (satu folder)

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient (Konsisten dengan Splash)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue[400]!, Colors.blue[800]!],
              ),
            ),
          ),

          // Dekorasi Background
          Positioned(
            bottom: 100,
            left: -30,
            child: CircleAvatar(
              radius: 80,
              // ignore: deprecated_member_use
              backgroundColor: Colors.white.withOpacity(0.08),
            ),
          ),

          // --- KONTEN UTAMA ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 30.0,
              ),
              child: Column(
                children: [
                  const Spacer(flex: 1),

                  // Logo
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/pusko.png',
                      height: 90,
                      width: 90,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Teks Sambutan
                  const Text(
                    "Kelola Jaringan\nLebih Efisien",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Pantau performa, atur tugas lapangan,\ndan selesaikan tiket gangguan dalam satu aplikasi.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Tombol Masuk
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke LoginScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(
                          0xFF1565C0,
                        ), // Warna teks biru
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "MASUK SEKARANG",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

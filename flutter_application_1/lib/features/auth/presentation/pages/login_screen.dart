import 'package:flutter/material.dart';
import '../../../tasks/presentation/pages/task_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isObscure = true;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TaskListScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Kita gunakan warna biru custom yang lebih elegan atau ambil dari theme
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      // Menggunakan Stack untuk menumpuk background dan konten
      body: Stack(
        children: [
          // 1. BACKGROUND GRADIENT
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryColor, // Warna utama
                  // ignore: deprecated_member_use
                  primaryColor.withOpacity(0.8), // Warna sedikit lebih terang
                  const Color(0xFF1E3A8A), // Warna biru tua (Dark Blue)
                ],
              ),
            ),
          ),

          // Dekorasi Lingkaran transparan untuk estetika (Opsional)
          Positioned(
            top: -50,
            left: -50,
            child: CircleAvatar(
              radius: 100,
              // ignore: deprecated_member_use
              backgroundColor: Colors.white.withOpacity(0.1),
            ),
          ),

          // 2. KONTEN UTAMA (CENTERED)
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Logo dan Judul di luar Card agar kontras dengan background
                  Icon(Icons.network_check, size: 70, color: Colors.white),
                  const SizedBox(height: 12),
                  const Text(
                    "NetOps Mobile",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Solusi Tugas Lapangan Terintegrasi",
                    style: TextStyle(
                      fontSize: 14,
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 3. CARD FORM LOGIN
                  Card(
                    elevation: 8, // Memberikan efek bayangan
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Selamat Datang",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Silakan masuk akun Anda",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // --- INPUT ID PEGAWAI (Gaya Modern) ---
                            TextFormField(
                              controller: _idController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "ID Pegawai",
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: primaryColor,
                                ),
                                filled: true,
                                fillColor:
                                    Colors.grey[100], // Warna latar input
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide
                                      .none, // Hilangkan garis border kaku
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                  ? "ID Pegawai wajib diisi"
                                  : null,
                            ),
                            const SizedBox(height: 16),

                            // --- INPUT PASSWORD (Gaya Modern) ---
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _isObscure,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: "Kata Sandi",
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: primaryColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                  ? "Kata sandi wajib diisi"
                                  : null,
                            ),
                            const SizedBox(height: 32),

                            // --- TOMBOL LOGIN (Rounded & Shadow) ---
                            SizedBox(
                              height: 52,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        "MASUK SEKARANG",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Footer Version
                  const SizedBox(height: 30),
                  Text(
                    "Versi 1.0.0",
                    style: TextStyle(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

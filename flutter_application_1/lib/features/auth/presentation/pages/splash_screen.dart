import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    // Animasi fade-in
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _isVisible = true;
      });
    });

    // Navigasi otomatis ke welcome
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[400]!, Colors.blue[900]!],
          ),
        ),
        child: Stack(
          children: [
            // Pattern Background
            Positioned(
              top: -60,
              right: -60,
              child: CircleAvatar(
                radius: 100,
                // ignore: deprecated_member_use
                backgroundColor: Colors.white.withOpacity(0.05),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -80,
              child: CircleAvatar(
                radius: 120,
                // ignore: deprecated_member_use
                backgroundColor: Colors.white.withOpacity(0.04),
              ),
            ),

            // Animasi Logo
            Center(
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _isVisible ? 1.0 : 0.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOut,
                  transform: Matrix4.translationValues(
                    0,
                    _isVisible ? 0 : 40,
                    0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.network_check,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "NetOps Mobile",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Field Service Management System",
                        style: TextStyle(
                          fontSize: 14,
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
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

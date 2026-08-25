import 'package:flutter/material.dart'; // import package Material Design

import 'login_screen.dart'; // import halaman Login
import 'register_screen.dart'; // import halaman Registrasi

// entry point aplikasi
void main() {
  runApp(const MyApp()); // menjalankan widget root MyApp
}

// StatelessWidget: root aplikasi, tidak punya state yang berubah
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: widget composition - membungkus seluruh app dengan tema & routing
    return MaterialApp(
      title: 'FormLogReg', // judul aplikasi
      debugShowCheckedModeBanner: false, // hilangkan banner debug
      theme: ThemeData(
        // ColorScheme: komposisi warna tema hijau (absen ganjil = hijau)
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(
          0xFFF4F7F4,
        ), // background abu kehijauan lembut
        fontFamily: 'Roboto',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green.shade600, width: 1.5),
          ),
        ),
      ),
      initialRoute: '/login', // route awal ke halaman login
      // Map<String, WidgetBuilder>: komposisi routing statis antar halaman
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}

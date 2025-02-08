import 'package:flutter/material.dart';
import 'package:baru_uas/pages/login_page.dart'; // Import halaman login
import 'package:baru_uas/pages/search_field.dart'; // Import halaman utama
import 'package:baru_uas/pages/register_page.dart'; // Import halaman registrasi

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login', // Set route awal ke halaman login
      routes: {
        '/login': (context) => const LoginPage(), // Route untuk halaman login
        '/home': (context) => const SearchField(), // Route untuk halaman utama
        '/register': (context) =>
            const RegisterPage(), // Route untuk halaman registrasi
      },
    );
  }
}

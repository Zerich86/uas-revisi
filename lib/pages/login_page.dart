import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Data login
  final Map<String, String> registeredUsers = {};

  @override
  Widget build(BuildContext context) {
    // Controller untuk input field
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input username
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            // Input password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            // Tombol login
            ElevatedButton(
              onPressed: () {
                // Ambil nilai dari input field
                final username = usernameController.text;
                final password = passwordController.text;

                // Validasi login
                if (registeredUsers.containsKey(username) &&
                    registeredUsers[username] == password) {
                  // Jika login berhasil, navigasi ke halaman utama
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // Jika login gagal, tampilkan pesan error
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Username atau password salah!'),
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            // Tombol registrasi
            TextButton(
              onPressed: () async {
                final result = await Navigator.pushNamed(context, '/register');
                if (result != null && result is Map<String, String>) {
                  setState(() {
                    registeredUsers.addAll(result);
                  });
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

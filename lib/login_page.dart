import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // TODO: Implement your real login logic here.
    // For now, just navigate to HomePage.
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _forgotPassword() {
    // TODO: Navigate to a proper Forgot Password page or dialog.
    // For demonstration, show a simple dialog or do nothing here.
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Obosani code?'),
            content: const Text('Benga biso na numero ya tel: 0994385299'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kanga'),
              ),
            ],
          ),
    );
  }

  void _registerNewUser() {
    // TODO: Navigate to a proper Register page.
    // For demonstration, show a simple dialog or do nothing here.
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Register New User'),
            content: const Text('Registration form goes here.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // CashApp-like bright green color
    const primaryGreen = Color(0xFF00D26A);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset('assets/fondation-gervais-logo.jpeg', height: 120),
                const SizedBox(height: 24),

                // Username Field
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Telephone (099438529)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Password Field
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Code',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _login,
                    child: const Text('Login', style: TextStyle(fontSize: 18)),
                  ),
                ),

                const SizedBox(height: 12),

                // Forgot password & Register links
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _forgotPassword,
                      child: const Text('Obosani code?'),
                    ),
                    TextButton(
                      onPressed: _registerNewUser,
                      child: const Text('Komisa na biso'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

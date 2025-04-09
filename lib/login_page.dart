import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Attempt to login by phone number
  Future<void> _login() async {
    final phone = _usernameController.text.trim();

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a phone number')),
      );
      return;
    }

    print('Attempting to fetch client with phoneNumber == $phone');

    try {
      // Use collectionGroup if data is in sub-collections "users/{uid}/clients"
      final querySnapshot =
          await FirebaseFirestore.instance
              .collectionGroup('clients')
              .where('phoneNumber', isEqualTo: phone)
              .limit(1)
              .get();

      print('Phone query returned ${querySnapshot.docs.length} doc(s).');
      for (var doc in querySnapshot.docs) {
        print('Doc ID: ${doc.id} => ${doc.data()}');
      }

      if (querySnapshot.docs.isNotEmpty) {
        final clientDoc = querySnapshot.docs.first;
        final clientData = clientDoc.data();

        // Navigate to PortalPage (or HomePage) with the clientData
        Navigator.pushReplacementNamed(
          context,
          '/portal',
          arguments: clientData,
        );
      } else {
        print('No client found with that phone. Trying a random fetch...');
        final testSnapshot =
            await FirebaseFirestore.instance
                .collectionGroup('clients')
                .limit(1)
                .get();

        print('Random fetch returned ${testSnapshot.docs.length} doc(s).');
        if (testSnapshot.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No matching phone, but Firestore has data.'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No data in "clients" at all.')),
          );
        }
      }
    } catch (e) {
      print('Error during Firestore query: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  /// Debug: Write a test doc to a top-level `testCollection`
  Future<void> _createTestDoc() async {
    print("Creating test document...");
    try {
      final ref = FirebaseFirestore.instance.collection('testCollection').doc();
      await ref.set({
        'message': 'Hi from the Flutter app!',
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('Wrote doc ${ref.id} to testCollection.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Created doc ${ref.id} in testCollection!')),
      );
    } catch (e) {
      print('Error writing doc: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error writing doc: $e')));
    }
  }

  void _forgotPassword() {
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

                // Phone # Field
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Telephone (ex: +243123456789)',
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
                    child: const Text('Kota', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 20),

                // Debug: Write test doc
                ElevatedButton(
                  onPressed: _createTestDoc,
                  child: const Text('Debug: Write Test Doc'),
                ),
                const SizedBox(height: 20),

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

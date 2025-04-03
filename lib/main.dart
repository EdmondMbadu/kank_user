import 'package:flutter/material.dart';
import 'home_page.dart';
import 'portal_page.dart';
import 'payment_page.dart';
import 'payment_history_page.dart';
import 'help_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CashApp-like bright green color
    const primaryGreen = Color(0xFF00D26A);

    return MaterialApp(
      title: 'Lingala Finance App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
      // Named routes for easy navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(), // bottom nav home
        '/portal': (context) => const PortalPage(),
        '/payment': (context) => const PaymentPage(),
        '/history': (context) => const PaymentHistoryPage(),
        '/help': (context) => const HelpPage(),
      },
    );
  }
}

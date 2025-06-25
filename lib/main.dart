// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'login_page.dart';
import 'home_page.dart';

/*───────────────────────────────────────────────────────────*/
/*– Global colour palette (blue-white-red) –*/
const Color kPrimaryBlue = Color(0xFF0A2A55); // deep navy (main brand colour)
const Color kAccentRed = Color(0xFFD7263D); // vivid accent red
const Color kLightBlue = Color(0xFFE7F0FF); // subtle background tint
/*───────────────────────────────────────────────────────────*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Lingala Finance App',
    debugShowCheckedModeBanner: false,

    /*── Global theme – modern Material 3 with our palette ──*/
    theme: ThemeData(
      useMaterial3: true,

      /* Colour scheme */
      colorScheme: ColorScheme.fromSeed(
        seedColor: kPrimaryBlue,
        brightness: Brightness.light,
        primary: kPrimaryBlue,
        secondary: kAccentRed,
        surface: Colors.white,
        background: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: kPrimaryBlue,
        onBackground: kPrimaryBlue,
      ),

      /* App-wide fonts & text */
      fontFamily: 'Helvetica',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
      ),

      /* Component overrides */
      scaffoldBackgroundColor: Colors.white,

      appBarTheme: const AppBarTheme(
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kPrimaryBlue.withOpacity(.25)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kPrimaryBlue.withOpacity(.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kAccentRed, width: 2),
        ),
        labelStyle: const TextStyle(color: kPrimaryBlue),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: kPrimaryBlue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),

      snackBarTheme: const SnackBarThemeData(
        backgroundColor: kAccentRed,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
    ),

    /*── Navigation ──*/
    initialRoute: '/',
    routes: {
      '/': (ctx) => const LoginPage(),
      '/home': (ctx) {
        final args =
            ModalRoute.of(ctx)!.settings.arguments as Map<String, dynamic>;
        return HomePage(clientData: args);
      },
    },
  );
}

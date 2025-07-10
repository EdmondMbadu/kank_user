// help_page_modern.dart – refined white/blue/red styling
import 'package:flutter/material.dart';

/*───────────────────────────────────────────────────────────*/
/*– Brand palette –*/
const Color kPrimaryBlue = Color(0xFF0A2A55); // deep navy-blue
const Color kAccentRed = Color(0xFFD7263D); // vivid red
const Color kLightBlue = Color(0xFFF5F9FF); // soft background tint

/*───────────────────────────────────────────────────────────*/
class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const phoneNumber = '085 333 567';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mituna',
          style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: kPrimaryBlue),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(height: 3, color: kAccentRed),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, kLightBlue],
          ),
        ),
        child: Center(
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // accent bar
                Container(
                  height: 6,
                  decoration: const BoxDecoration(
                    color: kAccentRed,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.support_agent,
                        size: 64,
                        color: kPrimaryBlue,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Besoin d’aide pour vos prêts, épargnes ou autres services ? Contactez notre équipe :',
                        style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryBlue,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),
                      Text(
                        phoneNumber,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryBlue,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.phone),
                          onPressed: () {
                            /* TODO: add url_launcher */
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: kAccentRed,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          label: const Text(
                            'Appeler',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

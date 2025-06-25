// help_page.dart
import 'package:flutter/material.dart';

/*───────────────────────────────────────────────────────────*/
/*– Brand palette –*/
const Color kPrimaryBlue = Color(0xFF0A2A55); // deep navy-blue
const Color kAccentRed = Color(0xFFD7263D); // vivid accent red
const Color kLightBlue = Color(0xFFE7F0FF); // background tint
const Color kCardBlue = Color(0xFF123D7B); // card background
/*───────────────────────────────────────────────────────────*/

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const phoneNumber = '085 333 567'; // thin space for better readability

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryBlue,
        title: const Text('Mituna', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      /*── Gradient background ──*/
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
            color: kCardBlue,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                /*── Stripe ─*/
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 6,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kAccentRed,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                  ),
                ),

                /*── Card body ─*/
                Container(
                  width: 320,
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.support_agent,
                        size: 60,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Pour toutes questions sur vos prêts, épargnes ou autres services, appelez-nous au :',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 22),

                      /*── Phone number ─*/
                      Text(
                        phoneNumber,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 32),

                      /*── Call button (optional) ─*/
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.phone),
                          onPressed: () {
                            // TODO: integrate url_launcher if desired
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: kPrimaryBlue,
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
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

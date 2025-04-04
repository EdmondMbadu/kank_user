import 'package:flutter/material.dart';

class PortalPage extends StatelessWidget {
  const PortalPage({Key? key}) : super(key: key);

  // Helper function to map credit score to a specific color range
  Color _getScoreColor(int value) {
    if (value < 50) {
      return const Color.fromRGBO(255, 0, 0, 1); // red
    } else if (value < 60) {
      return const Color.fromRGBO(255, 87, 34, 1); // red-orange
    } else if (value < 70) {
      return const Color.fromRGBO(255, 152, 0, 1); // orange
    } else if (value < 80) {
      return const Color.fromRGBO(255, 193, 7, 1); // yellow
    } else if (value < 90) {
      return const Color.fromRGBO(139, 195, 74, 1); // light green
    } else {
      return const Color.fromRGBO(40, 167, 69, 1); // green
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sample data
    final String remainingBalance = "12,000 FC";
    final String amountDue = "50,000 FC";
    final String savings = "5,000 FC";
    final String minPayment = "10,000 FC (20 Mars)";
    final int creditScore = 90; // e.g., range from 0-100 or 0-999

    return Scaffold(
      appBar: AppBar(title: const Text("Ebaboli"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Credit Score Circle + Label
            Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    // Dynamically color the circle:
                    color: _getScoreColor(creditScore),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "$creditScore",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text for contrast
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // The label: “Score Crédit”
                const Text(
                  "Score Crédit",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Main Green Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Theme.of(context).colorScheme.primary, // bright green
              child: Container(
                width: 320,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Niongo",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Big Remaining Balance
                    Text(
                      remainingBalance,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Amount Due
                    _buildFeatureRow(
                      icon: Icons.error_outline_rounded,
                      text: "Paiement Prochain : $amountDue",
                      context: context,
                      iconColor: Colors.redAccent,
                      fontSize: 22,
                    ),
                    const SizedBox(height: 8),
                    // Savings
                    _buildFeatureRow(
                      icon: Icons.savings_outlined,
                      text: "Epargnes : $savings",
                      context: context,
                      iconColor: Colors.white,
                      fontSize: 22,
                    ),
                    Container(padding: const EdgeInsets.only(bottom: 16)),
                    const SizedBox(height: 8),

                    // Minimum Payment
                    // _buildFeatureRow(
                    //   icon: Icons.notifications_active_rounded,
                    //   text: "Mbongo ya . : $minPayment",
                    //   context: context,
                    //   iconColor: Colors.white,
                    //   fontSize: 18,
                    // ),
                    // const SizedBox(height: 24),

                    // Action button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 14,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/payment');
                      },
                      child: const Text(
                        "Futa Sikoyo",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String text,
    required BuildContext context,
    Color? iconColor,
    double fontSize = 16,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor ?? Colors.white, size: 22),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

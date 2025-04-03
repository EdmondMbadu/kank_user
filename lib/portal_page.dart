import 'package:flutter/material.dart';

class PortalPage extends StatelessWidget {
  const PortalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data
    final String remainingBalance = "12,000 CDF";
    final String amountDue = "50,000 CDF";
    final String savings = "5,000 CDF";
    final String minPayment = "10,000 CDF (20 Mars)";

    return Scaffold(
      // We could omit an AppBar if we want the card to stand alone,
      // but let's keep it or remove as you see fit:
      appBar: AppBar(title: const Text("Ebaboli"), centerTitle: true),
      body: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          // The entire card is green
          color: Theme.of(context).colorScheme.primary,
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title: "Solde Ebotami" or "Remaining Balance"
                const Text(
                  "Solde Ebotami",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                // The main large price
                Text(
                  remainingBalance,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // The 3 items: Amount Due, Savings, Min Payment
                // We can show them as bullet points or check icons
                _buildFeatureRow(
                  icon: Icons.error_outline_rounded,
                  text: "Mbongo ya kofuta : $amountDue",
                  context: context,
                  iconColor: Colors.redAccent,
                  textColor: Colors.white,
                  fontSize: 18,
                ),
                const SizedBox(height: 8),
                _buildFeatureRow(
                  icon: Icons.savings_outlined,
                  text: "Bosombi : $savings",
                  context: context,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  fontSize: 18,
                ),
                const SizedBox(height: 8),
                _buildFeatureRow(
                  icon: Icons.notifications_active_rounded,
                  text: "Futa ya Min. : $minPayment",
                  context: context,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  fontSize: 18,
                ),
                const SizedBox(height: 24),

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
                    // For instance, navigate to Payment, or show details, etc.
                    Navigator.pushNamed(context, '/payment');
                  },
                  child: const Text(
                    "Futa Sikoyo",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String text,
    required BuildContext context,
    Color? iconColor,
    Color? textColor,
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
            style: TextStyle(
              fontSize: fontSize,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

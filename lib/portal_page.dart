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
    final String remainingBalance = "280,000 FC";
    final String savings = "60,000 FC";
    final String minPayment = "35,000 FC";
    final int creditScore = 90; // e.g., range from 0-100 or 0-999

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fondation Gervais",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Navigate back to the login page
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Greeting
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(
                    context,
                  ).style.copyWith(fontSize: 20, color: Colors.black),
                  children: [
                    const TextSpan(text: "Mbote, "),
                    TextSpan(
                      text: "Edmond.",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

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

              // Card 1: Niongo (Debt)
              _buildInfoCard(
                context,
                title: "Niongo Nionso",
                amount: remainingBalance,
                // Optionally include an icon or subtext inside if you like
              ),
              const SizedBox(height: 16),

              // Card 2: Epargnes (Savings)
              _buildInfoCard(context, title: "Epargnes", amount: savings),
              const SizedBox(height: 16),

              // Card 3: Next Payment (Niongo ya kofuta le ...)
              _buildNextPaymentCard(
                context,
                title: "Niongo ya kofuta le (20 Mars)",
                amount: minPayment,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable card for Niongo / Epargnes
  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required String amount,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.primary, // bright green
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Next Payment Card with "Futa Sikoyo" button
  Widget _buildNextPaymentCard(
    BuildContext context, {
    required String title,
    required String amount,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.primary, // bright green
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // "Futa Sikoyo" action button
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

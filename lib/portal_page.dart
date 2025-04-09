import 'package:flutter/material.dart';

class PortalPage extends StatelessWidget {
  const PortalPage({Key? key}) : super(key: key);

  // Helper: parse an int from dynamic (handles int or string)
  int _asInt(dynamic value, [int defaultValue = 0]) {
    if (value == null) return defaultValue;
    if (value is int) return value; // Already an int
    if (value is String) {
      return int.tryParse(value) ?? defaultValue;
    }
    // If it's something else (double, bool, etc.), fallback
    return defaultValue;
  }

  // Helper: parse a double from dynamic (handles int, double, or string)
  double _asDouble(dynamic value, [double defaultValue = 0.0]) {
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? defaultValue;
    }
    // If it's something else, fallback
    return defaultValue;
  }

  // Helper to map credit score to a specific color range
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
    // 1) Grab the client doc data from the route arguments
    final Map<String, dynamic>? clientData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // 2) Safely extract fields
    final firstName = clientData?['firstName'] ?? '';
    final lastName = clientData?['lastName'] ?? '';

    final creditScore = _asInt(clientData?['creditScore'], 50);

    final amountToPay = _asDouble(clientData?['amountToPay'], 0.0);
    final savingsVal = _asDouble(clientData?['savings'], 0.0);

    // Payment period range might be string or int
    final paymentPeriod = _asDouble(clientData?['paymentPeriodRange'], 1.0);

    // Min payment = total debt / paymentPeriod
    final double minPaymentVal = // Explicit type can also help clarity
        (paymentPeriod == 0) ? 0.0 : amountToPay / paymentPeriod;

    // Format for display
    final debtLeftText =
        '${_formatNumber(amountToPay)} FC'; // Also use interpolation here
    final savingsText = '${_formatNumber(savingsVal)} FC'; // And here
    // FIX 2: Use string interpolation instead of +
    final minPaymentText = '${_formatNumber(minPaymentVal)} FC';

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
              // Navigate back to login
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
              // Greeting: "Mbote, {firstName lastName}"
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(
                    context,
                  ).style.copyWith(fontSize: 20, color: Colors.black),
                  children: [
                    const TextSpan(text: "Mbote, "),
                    TextSpan(
                      text: "$firstName $lastName",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Credit Score Circle
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
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

              // Card 1: Niongo Nionso (debt)
              _buildInfoCard(
                context,
                title: "Niongo Nionso",
                amount: debtLeftText,
              ),
              const SizedBox(height: 16),

              // Card 2: Epargnes (savings)
              _buildInfoCard(context, title: "Epargnes", amount: savingsText),
              const SizedBox(height: 16),

              // Card 3: Next Payment
              _buildNextPaymentCard(
                context,
                title: "Niongo ya kofuta le ...",
                amount: minPaymentText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable card
  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required String amount,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.primary,
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

  /// Next Payment Card
  Widget _buildNextPaymentCard(
    BuildContext context, {
    required String title,
    required String amount,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.primary,
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

  /// Quick number formatter
  String _formatNumber(double value) {
    // In real apps, prefer using package:intl => NumberFormat("#,###").format(value)
    final str = value.toStringAsFixed(0);
    return str.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }
}

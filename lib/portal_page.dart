// portal_page.dart

import 'package:flutter/material.dart';

class PortalPage extends StatelessWidget {
  final Map<String, dynamic> clientData;
  const PortalPage({Key? key, required this.clientData}) : super(key: key);

  // Helper: parse an int from dynamic (handles int or string)
  int _asInt(dynamic value, [int defaultValue = 0]) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  // Helper: parse a double from dynamic (handles int, double, or string)
  double _asDouble(dynamic value, [double defaultValue = 0.0]) {
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  // Helper: map credit score to a color
  Color _getScoreColor(int value) {
    if (value < 50) return const Color.fromRGBO(255, 0, 0, 1);
    if (value < 60) return const Color.fromRGBO(255, 87, 34, 1);
    if (value < 70) return const Color.fromRGBO(255, 152, 0, 1);
    if (value < 80) return const Color.fromRGBO(255, 193, 7, 1);
    if (value < 90) return const Color.fromRGBO(139, 195, 74, 1);
    return const Color.fromRGBO(40, 167, 69, 1);
  }

  // Quick number formatter with thousands separators
  String _formatNumber(double value) {
    final str = value.toStringAsFixed(0);
    return str.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    // Extract fields
    final firstName = clientData['firstName'] as String? ?? '';
    final middleName = clientData['middleName'] as String? ?? '';
    final lastName = clientData['lastName'] as String? ?? '';
    final creditScore = _asInt(clientData['creditScore'], 50);

    final loanAmount = _asDouble(clientData['loanAmount'], 0.0);
    final debtLeft = _asDouble(clientData['debtLeft'], 0.0);
    final savingsVal = _asDouble(clientData['savings'], 0.0);

    final amountToPay = _asDouble(clientData['amountToPay'], 0.0);
    final paymentPeriod = _asDouble(clientData['paymentPeriodRange'], 1.0);
    final minPaymentVal =
        paymentPeriod == 0 ? 0.0 : amountToPay / paymentPeriod;

    // Formatted display strings
    final loanAmountText = '${_formatNumber(loanAmount)} FC';
    final amountToPayText = '${_formatNumber(amountToPay)} FC';
    final debtLeftText = '${_formatNumber(debtLeft)} FC';
    final savingsText = '${_formatNumber(savingsVal)} FC';
    final minPaymentText = '${_formatNumber(minPaymentVal)} FC';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fondation Gervais',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Greeting
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                  children: [
                    const TextSpan(text: 'Mbote, '),
                    TextSpan(
                      text: '$firstName $middleName $lastName',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Credit Score
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
                    '$creditScore',
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
                'Score Crédit',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Loan & Debt Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Niongo Nionso',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        amountToPayText,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Niongo Etikali',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        debtLeftText,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Savings Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Épargnes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        savingsText,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Next Payment Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Montant ya kofuta ...',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        minPaymentText,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// portal_page.dart

import 'package:flutter/material.dart';

class PortalPage extends StatelessWidget {
  final Map<String, dynamic> clientData;
  const PortalPage({Key? key, required this.clientData}) : super(key: key);

  // Helpers to parse/format
  DateTime _parseDate(String input) {
    // expected "MM-DD-YYYY"
    final parts = input.split('-');
    final month = int.tryParse(parts[0]) ?? 1;
    final day = int.tryParse(parts[1]) ?? 1;
    final year = int.tryParse(parts[2]) ?? DateTime.now().year;
    return DateTime(year, month, day);
  }

  String _formatDate(DateTime date) {
    const monthNames = [
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre',
    ];
    return '${monthNames[date.month - 1]} ${date.day}';
  }

  // Safely convert dynamic to int/double
  int _asInt(dynamic v, [int d = 0]) =>
      v == null
          ? d
          : v is int
          ? v
          : int.tryParse(v.toString()) ?? d;
  double _asDouble(dynamic v, [double d = 0]) =>
      v == null
          ? d
          : v is double
          ? v
          : v is int
          ? v.toDouble()
          : double.tryParse(v.toString()) ?? d;

  Color _getScoreColor(int value) {
    if (value < 50) return const Color.fromRGBO(255, 0, 0, 1);
    if (value < 60) return const Color.fromRGBO(255, 87, 34, 1);
    if (value < 70) return const Color.fromRGBO(255, 152, 0, 1);
    if (value < 80) return const Color.fromRGBO(255, 193, 7, 1);
    if (value < 90) return const Color.fromRGBO(139, 195, 74, 1);
    return const Color.fromRGBO(40, 167, 69, 1);
  }

  String _formatNumber(double value) {
    final str = value.toStringAsFixed(0);
    return str.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    // Extract raw fields
    final firstName = clientData['firstName'] as String? ?? '';
    final middleName = clientData['middleName'] as String? ?? '';
    final lastName = clientData['lastName'] as String? ?? '';
    final creditScore = _asInt(clientData['creditScore'], 50);

    final loanAmount = _asDouble(clientData['loanAmount'], 0.0);
    final debtLeft = _asDouble(clientData['debtLeft'], 0.0);
    final savingsVal = _asDouble(clientData['savings'], 0.0);

    final amountPaid = _asDouble(clientData['amountPaid'], 0.0);
    final amountToPay = _asDouble(clientData['amountToPay'], 0.0);
    final paymentPeriod = _asDouble(clientData['paymentPeriodRange'], 1.0);

    // Compute date range
    final rawStart = clientData['debtCycleStartDate'] as String? ?? '';
    final startDate = _parseDate(rawStart);
    final endDate = startDate.add(Duration(days: (paymentPeriod * 7).toInt()));
    final debtStart = _formatDate(startDate);
    final debtEnd = _formatDate(endDate);

    // Determine if overdue
    final now = DateTime.now();
    final isOverdue = now.isAfter(endDate);

    // Format strings
    final loanAmountText = '${_formatNumber(loanAmount)} FC';
    final amountToPayText = '${_formatNumber(amountPaid)} FC';
    final debtLeftText = '${_formatNumber(debtLeft)} FC';
    final savingsText = '${_formatNumber(savingsVal)} FC';
    final minPaymentVal =
        paymentPeriod == 0
            ? debtLeft
            : (amountToPay / paymentPeriod) > debtLeft
            ? debtLeft
            : amountToPay / paymentPeriod;
    final minPaymentText = '${_formatNumber(minPaymentVal)} FC';

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
                  style: DefaultTextStyle.of(
                    context,
                  ).style.copyWith(fontSize: 20, color: Colors.black),
                  children: [
                    const TextSpan(text: 'Mbote, '),
                    TextSpan(
                      text: '$firstName $middleName $lastName',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
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

              // Loan & Debt Card (static labels)
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
                      // Date range
                      Text(
                        '$debtStart – $debtEnd',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Niongo Ofuti',
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

              // Next Payment Card with overdue logic
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
                      // Conditional title
                      Text(
                        isOverdue
                            ? 'Niongo ya kofuta ⚠️  en retard'
                            : 'Niongo ya kofuta par semaines',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isOverdue ? Colors.red : Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Amount due
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

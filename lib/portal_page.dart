// portal_page.dart
import 'package:flutter/material.dart';

class PortalPage extends StatelessWidget {
  final Map<String, dynamic> clientData;
  const PortalPage({Key? key, required this.clientData}) : super(key: key);

  /*──────────── Helpers ────────────*/
  DateTime _parseDate(String input) {
    // expected format: "MM-DD-YYYY"
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

  int _asInt(dynamic v, [int d = 0]) =>
      v == null ? d : (v is int ? v : int.tryParse(v.toString()) ?? d);
  double _asDouble(dynamic v, [double d = 0]) =>
      v == null
          ? d
          : v is double
          ? v
          : v is int
          ? v.toDouble()
          : double.tryParse(v.toString()) ?? d;

  Color _getScoreColor(int v) {
    if (v < 50) return const Color.fromRGBO(255, 0, 0, 1);
    if (v < 60) return const Color.fromRGBO(255, 87, 34, 1);
    if (v < 70) return const Color.fromRGBO(255, 152, 0, 1);
    if (v < 80) return const Color.fromRGBO(255, 193, 7, 1);
    if (v < 90) return const Color.fromRGBO(139, 195, 74, 1);
    return const Color.fromRGBO(40, 167, 69, 1);
  }

  String _formatNumber(double v) {
    final str = v.toStringAsFixed(0);
    return str.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  /*──────────── UI ────────────*/
  @override
  Widget build(BuildContext context) {
    /*── Extract data ──*/
    final firstName = clientData['firstName'] as String? ?? '';
    final middleName = clientData['middleName'] as String? ?? '';
    final lastName = clientData['lastName'] as String? ?? '';
    final creditScore = _asInt(clientData['creditScore'], 50);

    final debtLeft = _asDouble(clientData['debtLeft'], 0);
    final savingsVal = _asDouble(clientData['savings'], 0);

    final amountPaid = _asDouble(clientData['amountPaid'], 0);
    final amountToPay = _asDouble(clientData['amountToPay'], 0);
    final paymentPeriod = _asDouble(clientData['paymentPeriodRange'], 1);

    // dates
    final startDateStr = clientData['debtCycleStartDate'] as String? ?? '';
    final startDate = _parseDate(startDateStr);
    final endDate = startDate.add(Duration(days: (paymentPeriod * 7).toInt()));
    final debtStart = _formatDate(startDate);
    final debtEnd = _formatDate(endDate);

    final isOverdue = DateTime.now().isAfter(endDate);

    /*── Formatted strings ──*/
    final amountToPayText = '${_formatNumber(amountPaid)} FC';
    final debtLeftText = '${_formatNumber(debtLeft)} FC';
    final savingsText = '${_formatNumber(savingsVal)} FC';

    final minPaymentVal =
        paymentPeriod == 0
            ? debtLeft
            : (amountToPay / paymentPeriod) > debtLeft
            ? debtLeft
            : amountToPay / paymentPeriod;
    final minPaymentText = '${_formatNumber(minPaymentVal)} FC';

    /*── Colours ──*/
    final cardColor = const Color.fromARGB(255, 31, 104, 32);
    final cardColorDate = const Color.fromARGB(255, 160, 232, 175);

    /*── Scaffold ──*/
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*── Date banner ──*/
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: cardColorDate,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 4),
                  ],
                ),
                child: Text(
                  '$debtStart — $debtEnd',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /*── Greeting ──*/
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(
                    context,
                  ).style.copyWith(fontSize: 20),
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

              /*── Credit badge ──*/
              _ScoreBadge(
                score: creditScore,
                color: _getScoreColor(creditScore),
              ),
              const SizedBox(height: 20),

              /*── Money cards ──*/
              _MoneyCard(
                title: 'Niongo Ofuti',
                amount: amountToPayText,
                color: cardColor,
              ),
              const SizedBox(height: 16),
              _MoneyCard(
                title: 'Niongo Etikali',
                amount: debtLeftText,
                color: cardColor,
              ),
              const SizedBox(height: 16),
              _MoneyCard(
                title: 'Épargnes',
                amount: savingsText,
                color: cardColor,
              ),
              const SizedBox(height: 16),

              /*── Upcoming / overdue payment ──*/
              _MoneyCard(
                title:
                    isOverdue
                        ? 'Niongo ya kofuta ⚠️ en retard'
                        : 'Niongo ya kofuta par semaines',
                amount: isOverdue ? debtLeftText : minPaymentText,
                color:
                    isOverdue
                        ? const Color.fromARGB(255, 167, 39, 39)
                        : cardColor,
                titleColor: isOverdue ? Colors.white : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*──────────── Re‑usable widgets ────────────*/

class _ScoreBadge extends StatelessWidget {
  final int score;
  final Color color;
  const _ScoreBadge({required this.score, required this.color});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color,
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
            '$score',
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
    ],
  );
}

class _MoneyCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final Color? titleColor;
  const _MoneyCard({
    required this.title,
    required this.amount,
    required this.color,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) => Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    color: color,
    child: Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center, // centres children
        children: [
          Text(
            title,
            textAlign: TextAlign.center, // centres multiline title
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleColor ?? Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            textAlign: TextAlign.center, // centres amount
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

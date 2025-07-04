// portal_page.dart
import 'package:flutter/material.dart';

/*───────────────────────────────────────────────────────────*/
/*– Brand palette (shared) –*/
const Color kPrimaryBlue = Color(0xFF0A2A55); // deep navy-blue
const Color kAccentRed = Color(0xFFD7263D); // vivid red
const Color kLightBlue = Color(0xFFE7F0FF); // soft background tint
const Color kCardBlue = Color(0xFF123D7B); // card background
/*───────────────────────────────────────────────────────────*/

class PortalPage extends StatelessWidget {
  final Map<String, dynamic> clientData;
  const PortalPage({Key? key, required this.clientData}) : super(key: key);

  /*──────────── Helpers ────────────*/
  DateTime _parseDate(String v) {
    final p = v.split('-').map((e) => int.tryParse(e) ?? 1).toList();
    return p.length >= 3 ? DateTime(p[2], p[0], p[1]) : DateTime.now();
  }

  String _fmtDate(DateTime d) {
    const m = [
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
    return '${m[d.month - 1]} ${d.day} ${d.year}';
  }

  int _asInt(dynamic v, [int d = 0]) =>
      v == null ? d : (v is int ? v : int.tryParse(v.toString()) ?? d);
  double _asDbl(dynamic v, [double d = 0]) =>
      v == null
          ? d
          : (v is double
              ? v
              : (v is int ? v.toDouble() : double.tryParse(v.toString()) ?? d));

  Color _scoreColor(int s) {
    if (s < 50) return kAccentRed;
    if (s < 70) return Colors.orange;
    if (s < 90) return Colors.amber;
    return const Color(0xFF2ECC71); // green
  }

  String _fmtNum(num v) {
    final s = v.toStringAsFixed(0);
    return s.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  /*──────────── UI ────────────*/
  @override
  Widget build(BuildContext context) {
    /*─ Data ─*/
    final f = clientData['firstName'] ?? '';
    final m = clientData['middleName'] ?? '';
    final l = clientData['lastName'] ?? '';
    final sco = _asInt(clientData['creditScore'], 50);

    final debt = _asDbl(clientData['debtLeft']);
    final savings = _asDbl(clientData['savings']);
    final paid = _asDbl(clientData['amountPaid']);
    final toPay = _asDbl(clientData['amountToPay']);
    final periodW = _asDbl(clientData['paymentPeriodRange'], 1);

    final start = _parseDate(clientData['debtCycleStartDate'] ?? '');
    final end = start.add(Duration(days: (periodW * 7).toInt()));
    final overdue = DateTime.now().isAfter(end);

    final minWeek =
        periodW == 0
            ? debt
            : (toPay / periodW) > debt
            ? debt
            : (toPay / periodW);

    /*─ Build ─*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryBlue,
        title: const Text(
          'Fondation Gervais',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),

      /*── Gradient background ─*/
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, kLightBlue],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                /*── Cycle chip ─*/
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: kLightBlue,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: kPrimaryBlue.withOpacity(.2)),
                  ),
                  child: Text(
                    '${_fmtDate(start)} — ${_fmtDate(end)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                /*── Greeting ─*/
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(
                      context,
                    ).style.copyWith(fontSize: 20),
                    children: [
                      const TextSpan(text: 'Mbote, '),
                      TextSpan(
                        text: '$f $m $l',
                        style: const TextStyle(
                          color: kPrimaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),

                /*── Score ─*/
                _ScoreBadge(score: sco, color: _scoreColor(sco)),
                const SizedBox(height: 30),

                /*── Money cards grid ─*/
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _MoneyCard(
                      title: 'Niongo Ofuti',
                      amount: '${_fmtNum(paid)} FC',
                      color: kCardBlue,
                    ),
                    _MoneyCard(
                      title: 'Niongo Etikali',
                      amount: '${_fmtNum(debt)} FC',
                      color: kCardBlue,
                    ),
                    _MoneyCard(
                      title: 'Épargnes',
                      amount: '${_fmtNum(savings)} FC',
                      color: kCardBlue,
                    ),
                    _MoneyCard(
                      title: overdue ? '⚠️ Retard à payer' : 'Minimum hebdo',
                      amount:
                          overdue
                              ? '${_fmtNum(debt)} FC'
                              : '${_fmtNum(minWeek)} FC',
                      color: overdue ? kAccentRed : kCardBlue,
                      titleColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*────────── Re-usable widgets ──────────*/
class _ScoreBadge extends StatelessWidget {
  final int score;
  final Color color;
  const _ScoreBadge({required this.score, required this.color});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '$score',
            style: const TextStyle(
              fontSize: 28,
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
    elevation: 6,
    color: color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    child: Container(
      width: 160,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: titleColor ?? Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

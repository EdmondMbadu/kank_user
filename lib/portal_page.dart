// portal_page_modern.dart – refreshed UI inspired by the Bank of America mobile look
import 'package:flutter/material.dart';

/*───────────────────────────────────────────────────────────*/
/*– Brand palette (shared) –*/
const Color kPrimaryBlue = Color(0xFF0A2A55); // deep navy-blue
const Color kAccentRed = Color(0xFFD7263D); // vivid red
const Color kLightBlue = Color(0xFFE7F0FF); // soft background tint
const Color kCardBorder = Color(0xFF123D7B); // subtle card border for neutrals

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
          : (v is num ? v.toDouble() : double.tryParse(v.toString()) ?? d);

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: kPrimaryBlue),
          onPressed: () {},
        ),
        title: const Text(
          'Fondation Gervais',
          style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.mail_outline, color: kPrimaryBlue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: kPrimaryBlue),
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
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /*── Cycle pill ─*/
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: kLightBlue,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: kPrimaryBlue.withOpacity(.15)),
                    ),
                    child: Text(
                      '${_fmtDate(start)} — ${_fmtDate(end)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                /*── Greeting ─*/
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
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
                Align(
                  alignment: Alignment.center,
                  child: _ScoreBadge(score: sco, color: _scoreColor(sco)),
                ),
                const SizedBox(height: 32),

                /*── Accounts Section Title ─*/
                _SectionHeader(title: 'Comptes'),
                const SizedBox(height: 12),

                /*── Money cards grid ─*/
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _MoneyCard(
                      title: 'Niongo Ofuti',
                      amount: '${_fmtNum(paid)} FC',
                      accentColor: kPrimaryBlue,
                    ),
                    _MoneyCard(
                      title: 'Niongo Etikali',
                      amount: '${_fmtNum(debt)} FC',
                      accentColor: kPrimaryBlue,
                    ),
                    _MoneyCard(
                      title: 'Épargnes',
                      amount: '${_fmtNum(savings)} FC',
                      accentColor: kPrimaryBlue,
                    ),
                    _MoneyCard(
                      title: overdue ? '⚠️ Retard à payer' : 'Minimum hebdo',
                      amount:
                          overdue
                              ? '${_fmtNum(debt)} FC'
                              : '${_fmtNum(minWeek)} FC',
                      accentColor: overdue ? kAccentRed : kPrimaryBlue,
                      titleColor: overdue ? kAccentRed : kPrimaryBlue,
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
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 5,
        height: 20,
        decoration: BoxDecoration(
          color: kPrimaryBlue,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    ],
  );
}

class _ScoreBadge extends StatelessWidget {
  final int score;
  final Color color;
  const _ScoreBadge({required this.score, required this.color});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(.9), color.withOpacity(.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.12),
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
  final Color accentColor;
  final Color? titleColor;
  const _MoneyCard({
    required this.title,
    required this.amount,
    required this.accentColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: 170,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: kCardBorder.withOpacity(.1)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.06),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // accent line
        Container(
          height: 5,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                amount,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryBlue,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

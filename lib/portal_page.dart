// portal_page_modern.dart – v2 with two large cards (Debt & Savings)
import 'package:flutter/material.dart';

/*───────────────────────────────────────────────────────────*/
/*– Brand palette –*/
const Color kPrimaryBlue = Color(0xFF0A2A55); // deep navy-blue
const Color kAccentRed = Color(0xFFD7263D); // vivid red
const Color kLightBlue = Color(0xFFE7F0FF); // soft background tint
const Color kBorderColor = Color(0xFF123D7B); // subtle card border

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
    return const Color(0xFF2ECC71);
  } // green

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
            : ((toPay / periodW) > debt ? debt : (toPay / periodW));

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

                /*── Accounts Section ─*/
                _SectionHeader(title: 'Comptes'),
                const SizedBox(height: 12),

                /*── Debt Card ─*/
                _DebtCard(
                  debtLeft: debt,
                  alreadyPaid: paid,
                  minWeekly: minWeek,
                  overdue: overdue,
                ),
                const SizedBox(height: 20),
                /*── Savings Card ─*/
                _SavingsCard(savings: savings),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*────────── Widgets ──────────*/
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

class _DebtCard extends StatelessWidget {
  final double debtLeft;
  final double alreadyPaid;
  final double minWeekly;
  final bool overdue;
  const _DebtCard({
    required this.debtLeft,
    required this.alreadyPaid,
    required this.minWeekly,
    required this.overdue,
  });

  @override
  Widget build(BuildContext context) => Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    child: ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Niongo Etikali',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kPrimaryBlue,
            ),
          ),
          Text(
            '${_fmtNumStatic(debtLeft)} FC',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: kPrimaryBlue,
            ),
          ),
        ],
      ),
      children: [
        const Divider(height: 1),
        const SizedBox(height: 12),
        _InfoRow(label: 'Déjà payé', value: '${_fmtNumStatic(alreadyPaid)} FC'),
        const SizedBox(height: 8),
        _InfoRow(
          label: overdue ? '⚠️ Retard à payer' : 'Minimum hebdo',
          value: '${_fmtNumStatic(overdue ? debtLeft : minWeekly)} FC',
          valueColor: overdue ? kAccentRed : kPrimaryBlue,
        ),
      ],
    ),
  );
}

class _SavingsCard extends StatelessWidget {
  final double savings;
  const _SavingsCard({required this.savings});
  @override
  Widget build(BuildContext context) => Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Épargnes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Disponible',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
          Text(
            '${_fmtNumStatic(savings)} FC',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: kPrimaryBlue,
            ),
          ),
        ],
      ),
    ),
  );
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _InfoRow({required this.label, required this.value, this.valueColor});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: valueColor ?? kPrimaryBlue,
        ),
      ),
    ],
  );
}

/*── Static formatter helper because _DebtCard is outside main class ─*/
String _fmtNumStatic(num v) {
  final s = v.toStringAsFixed(0);
  return s.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );
}

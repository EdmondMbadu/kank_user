// payment_history_page_modern.dart – v2.1 (Futa icon = money)
import 'package:flutter/material.dart';
import 'payment_page.dart'; // ➜ ajuste le chemin si nécessaire

/*───────────────────────────────────────────────────────────*/
/*– Shared palette –*/
const Color kPrimaryBlue = Color(0xFF0A2A55); // deep navy-blue
const Color kAccentRed = Color(0xFFD7263D); // vivid red
const Color kLightBlue = Color(0xFFF5F9FF); // very soft background tint

/*───────────────────────────────────────────────────────────*/
typedef PaymentEntry = MapEntry<DateTime, double>;

class PaymentHistoryPage extends StatelessWidget {
  final Map<String, dynamic> clientData;
  const PaymentHistoryPage({Key? key, required this.clientData})
    : super(key: key);

  /*──────────── Helpers ────────────*/
  DateTime _parseKey(String k) {
    final p = k.split('-').map((e) => int.tryParse(e) ?? 0).toList();
    return p.length >= 6
        ? DateTime(p[2], p[0], p[1], p[3], p[4], p[5])
        : DateTime.now();
  }

  String _formatFr(DateTime d) {
    const days = [
      '',
      'Lundi',
      'Mardi',
      'Mercredi',
      'Jeudi',
      'Vendredi',
      'Samedi',
      'Dimanche',
    ];
    const months = [
      '',
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
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '${days[d.weekday]} ${d.day} ${months[d.month]} ${d.year} à $hh:$mm';
  }

  @override
  Widget build(BuildContext context) {
    final rawMap = clientData['payments'] as Map<String, dynamic>? ?? {};
    final List<PaymentEntry> entries =
        rawMap.entries
            .map(
              (e) => MapEntry(
                _parseKey(e.key),
                double.tryParse(e.value.toString()) ?? 0,
              ),
            )
            .toList()
          ..sort((a, b) => b.key.compareTo(a.key));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Historique des paiements',
          style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: kPrimaryBlue),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(height: 3, color: kAccentRed),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, kLightBlue],
          ),
        ),
        child:
            (entries.isEmpty)
                ? const Center(
                  child: Text(
                    'Aucun paiement enregistré',
                    style: TextStyle(fontSize: 16),
                  ),
                )
                : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: entries.length + 1, // +1 for header tile
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [_FutaShortcut(), const SizedBox(height: 20)],
                      );
                    }
                    final e = entries[index - 1];
                    final dateStr = _formatFr(e.key);
                    final amountStr = '${e.value.toStringAsFixed(0)} FC';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: kPrimaryBlue.withOpacity(.08),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                    color: kAccentRed,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    title: Text(
                                      dateStr,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryBlue,
                                      ),
                                    ),
                                    trailing: Text(
                                      amountStr,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryBlue,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}

/*────────── Shortcut tile ──────────*/
class _FutaShortcut extends StatelessWidget {
  const _FutaShortcut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PaymentPage()),
      );
    },
    borderRadius: BorderRadius.circular(18),
    child: Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: kPrimaryBlue.withOpacity(.08)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.attach_money, size: 40, color: kPrimaryBlue),
          SizedBox(height: 8),
          Text(
            'Futa',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: kPrimaryBlue,
            ),
          ),
          SizedBox(height: 2),
          Text('Payer', style: TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    ),
  );
}

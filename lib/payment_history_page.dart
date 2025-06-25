// payment_history_page.dart
import 'package:flutter/material.dart';

/*───────────────────────────────────────────────────────────*/
/*– Brand palette (shared with the whole app) –*/
const Color kPrimaryBlue = Color(0xFF0A2A55); // deep navy-blue
const Color kAccentRed = Color(0xFFD7263D); // vivid accent red
const Color kLightBlue = Color(0xFFE7F0FF); // gentle bg tint
const Color kCardBlue = Color(0xFF123D7B); // card background
/*───────────────────────────────────────────────────────────*/

typedef PaymentEntry = MapEntry<DateTime, double>;

class PaymentHistoryPage extends StatelessWidget {
  final Map<String, dynamic> clientData;
  const PaymentHistoryPage({Key? key, required this.clientData})
    : super(key: key);

  /*──────────── Helpers ────────────*/
  /// Parse timestamp key "M-D-YYYY-HH-MM-SS"
  DateTime _parseKey(String k) {
    final p = k.split('-').map((e) => int.tryParse(e) ?? 0).toList();
    return p.length >= 6
        ? DateTime(p[2], p[0], p[1], p[3], p[4], p[5])
        : DateTime.now();
  }

  /// "Vendredi 18 Avril 2025 à 16 :15"
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
    /*── Build & sort list ──*/
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
      appBar: AppBar(
        backgroundColor: kPrimaryBlue,
        title: const Text(
          'Détails de Paiements',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      /*── Background gradient ──*/
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, kLightBlue],
          ),
        ),

        /*── List of payments ──*/
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: entries.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final e = entries[i];
            final date = _formatFr(e.key);
            final amount = '${e.value.toStringAsFixed(0)} FC';

            return Card(
              color: kCardBlue,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 18,
                ),
                leading: CircleAvatar(
                  backgroundColor: kAccentRed,
                  child: Text(
                    date[0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                trailing: Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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

// payment_history_page.dart

import 'package:flutter/material.dart';

typedef PaymentEntry = MapEntry<DateTime, double>;

class PaymentHistoryPage extends StatelessWidget {
  final Map<String, dynamic> clientData;
  const PaymentHistoryPage({Key? key, required this.clientData})
    : super(key: key);

  /// Parse the timestamp key "M-D-YYYY-HH-MM-SS" into a DateTime
  DateTime _parseKey(String key) {
    final parts = key.split('-').map((p) => int.tryParse(p) ?? 0).toList();
    if (parts.length >= 6) {
      return DateTime(
        parts[2],
        parts[0],
        parts[1],
        parts[3],
        parts[4],
        parts[5],
      );
    }
    return DateTime.now();
  }

  /// Format DateTime in french: e.g. "Vendredi 18 Avril 2025 a 16:15"
  String _formatFrench(DateTime dt) {
    const days = [
      '', // dummy index 0
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
    final dayName = days[dt.weekday];
    final monthName = months[dt.month];
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    return '$dayName ${dt.day} $monthName ${dt.year} a $hh:$mm';
  }

  @override
  Widget build(BuildContext context) {
    // Extract payments map
    final paymentsMap = clientData['payments'] as Map<String, dynamic>? ?? {};

    // Convert to list of (DateTime, amount)
    final List<PaymentEntry> entries =
        paymentsMap.entries
            .map(
              (e) => MapEntry(
                _parseKey(e.key),
                double.tryParse(e.value.toString()) ?? 0.0,
              ),
            )
            .toList();

    // Sort descending by date
    entries.sort((a, b) => b.key.compareTo(a.key));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details de Paiements',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: entries.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final entry = entries[index];
          final dateStr = _formatFrench(entry.key);
          final amountStr = '${entry.value.toStringAsFixed(0)} FC';
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 0,
            ),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                dateStr[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              dateStr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            trailing: Text(
              amountStr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}

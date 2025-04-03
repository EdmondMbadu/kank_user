import 'package:flutter/material.dart';

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> payments = [
      {"date": "08/10/2023", "desc": "Mbongo Pasi", "amount": "\$6.09"},
      {"date": "07/10/2023", "desc": "Mbongo Pasi", "amount": "\$6.09"},
      {"date": "06/10/2023", "desc": "Mbongo Pasi", "amount": "\$6.09"},
      {"date": "06/10/2023", "desc": "Mbongo Pasi", "amount": "\$6.09"},
      {"date": "05/10/2023", "desc": "Mbongo Pasi", "amount": "\$6.09"},
      {"date": "04/10/2023", "desc": "Mbongo Pasi", "amount": "\$6.09"},
      {"date": "03/10/2023", "desc": "Mbongo Pasi", "amount": "\$6.09"},
      {"date": "02/10/2023", "desc": "Mbongo Pasi", "amount": "\$6.09"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Histoire ya Paiement",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: payments.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = payments[index];
                return ListTile(
                  dense: true,
                  leading: Text(
                    item["date"] ?? "",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  title: Text(item["desc"] ?? ""),
                  trailing: Text(
                    item["amount"] ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chevron_left),
              ),
              const Text(
                "1  |  2  |  3  ...",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Kanga", // "Close"
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

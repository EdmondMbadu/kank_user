import 'package:flutter/material.dart';

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customers = [
      {"name": "Neil Sims", "email": "email@windster.com", "amount": "\$320"},
      {
        "name": "Bonnie Green",
        "email": "email@windster.com",
        "amount": "\$3467",
      },
      {
        "name": "Michael Gough",
        "email": "email@windster.com",
        "amount": "\$67",
      },
      {"name": "Lana Byrd", "email": "email@windster.com", "amount": "\$367"},
      {
        "name": "Thomes Lean",
        "email": "email@windster.com",
        "amount": "\$2367",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Histoire ya Paiement',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Latest Customers',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('View all'),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: customers.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (ctx, i) {
                      final c = customers[i];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text(
                            c["name"]![0],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          c["name"]!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          c["email"]!,
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: Text(
                          c["amount"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.chevron_left),
              SizedBox(width: 8),
              Text(
                '1  |  2  |  3  ...',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 8),
              Icon(Icons.chevron_right),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Kanga',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

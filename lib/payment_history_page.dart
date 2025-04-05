import 'package:flutter/material.dart';

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example data
    final List<Map<String, String>> customers = [
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
          "Histoire ya Paiement",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // “Latest Customers” box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Column(
                children: [
                  // Header Row
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Latest Customers",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: “View all” action
                          },
                          child: const Text("View all"),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  // List of customers
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: customers.length,
                    separatorBuilder:
                        (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final data = customers[index];
                      final name = data["name"] ?? "";
                      final email = data["email"] ?? "";
                      final amount = data["amount"] ?? "";

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text(
                            name.isNotEmpty ? name[0] : "?",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(name, style: const TextStyle(fontSize: 14)),
                        subtitle: Text(
                          email,
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: Text(
                          amount,
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

          // Pagination
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // TODO: go to previous page
                },
                icon: const Icon(Icons.chevron_left),
              ),
              const Text(
                "1  |  2  |  3  ...",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              IconButton(
                onPressed: () {
                  // TODO: go to next page
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // “Close” (Kanga) button
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
              "Kanga",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

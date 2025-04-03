import 'package:flutter/material.dart';

class PortalPage extends StatelessWidget {
  const PortalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data
    final String name = "Masevo Konde";
    final String memberSince = "01/10/2023";
    final int creditScore = 330;
    final double borrowed = 81.22;
    final double paid = 40.22;
    final double difference = 41.00;
    final double minPayment = 6.09;
    final String dueDate = "10 Aug";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ebaboli",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          // Big rounded container with bright green background
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name & Member Since
              Text(
                name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "Membre banda $memberSince",
                style: const TextStyle(fontSize: 15, color: Colors.white70),
              ),
              const SizedBox(height: 24),

              // Info grid
              Wrap(
                spacing: 24,
                runSpacing: 16,
                children: [
                  _infoItem("Score ya Crédit", "$creditScore", context),
                  _infoItem(
                    "Mbongo ezwama",
                    "\$${borrowed.toStringAsFixed(2)}",
                    context,
                  ),
                  _infoItem(
                    "Mbongo efutami",
                    "\$${paid.toStringAsFixed(2)}",
                    context,
                  ),
                  _infoItem(
                    "Ndenge",
                    "\$${difference.toStringAsFixed(2)}",
                    context,
                  ),
                  _infoItem(
                    "Futa ya Min.",
                    "\$${minPayment.toStringAsFixed(2)}",
                    context,
                  ),
                  _infoItem("Daté ya kofuta", dueDate, context),
                ],
              ),

              const SizedBox(height: 32),
              // Buttons row
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/history'),
                      child: const Text(
                        "Misala",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green[500],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/payment'),
                      child: const Text(
                        "Futa",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Help link
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green[500],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/help'),
                  child: const Text(
                    "Lisungi",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem(String label, String value, BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

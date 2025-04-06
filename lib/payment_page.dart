import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // Store the current typed amount (as text)
  String _enteredAmount = "0";

  /// Append a digit or decimal point to the current amount
  void _appendValue(String value) {
    setState(() {
      // If we currently have "0" and we tap a digit, replace "0"
      // But if we tap ".", allow "0." to appear
      if (_enteredAmount == "0" && value != ".") {
        _enteredAmount = value;
      } else {
        // Prevent multiple decimal points
        if (value == "." && _enteredAmount.contains(".")) return;
        _enteredAmount += value;
      }
    });
  }

  /// Delete the last character of the typed amount
  void _deleteLastDigit() {
    if (_enteredAmount.isNotEmpty) {
      setState(() {
        _enteredAmount = _enteredAmount.substring(0, _enteredAmount.length - 1);
        // If we delete all digits, revert to "0"
        if (_enteredAmount.isEmpty) {
          _enteredAmount = "0";
        }
      });
    }
  }

  /// Handle "Tínda" (submit)
  void _submit() {
    // For demonstration, just show a dialog with the typed amount.
    // Replace this with your real payment submission logic.
    final amountDouble = double.tryParse(_enteredAmount) ?? 0.0;
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Mbongo efutami"),
            content: Text("Ofuti $amountDouble FC"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Futa Mbongo"), centerTitle: true),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            width: 340,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display the entered amount in large text
                Text(
                  "$_enteredAmount FC",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // Numeric keypad
                _buildNumberPad(),

                const SizedBox(height: 16),

                // Buttons row
                Row(
                  children: [
                    // Tika (Cancel)
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          side: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 2,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Tika", // Cancel
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Tínda (Submit)
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _submit,
                        child: const Text(
                          "Tínda", // Submit
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
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

  /// Build a 3x4 keypad (digits, decimal point, and delete)
  Widget _buildNumberPad() {
    final buttons = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      ".",
      "0",
      "X",
    ];

    return SizedBox(
      width: 300,
      // Use Wrap, GridView, or Table for layout
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300, width: 1),
        children: [
          TableRow(children: buttons.sublist(0, 3).map(_buildKey).toList()),
          TableRow(children: buttons.sublist(3, 6).map(_buildKey).toList()),
          TableRow(children: buttons.sublist(6, 9).map(_buildKey).toList()),
          TableRow(children: buttons.sublist(9, 12).map(_buildKey).toList()),
        ],
      ),
    );
  }

  Widget _buildKey(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(60, 60),
        ),
        onPressed: () {
          if (value == "X") {
            _deleteLastDigit();
          } else {
            _appendValue(value);
          }
        },
        child: Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

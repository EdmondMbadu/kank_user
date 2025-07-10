// payment_page_modern.dart – blue/red polish + Futa action
import 'package:flutter/material.dart';

/*───────────────────────────────────────────────────────────*/
/* – Palette – */
const Color kPrimaryBlue = Color(0xFF0A2A55);
const Color kAccentRed = Color(0xFFD7263D);
const Color kLightBlue = Color(0xFFF5F9FF);

/*───────────────────────────────────────────────────────────*/
class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _amount = "0";

  void _append(String v) {
    setState(() {
      if (_amount == "0" && v != ".")
        _amount = v;
      else {
        if (v == "." && _amount.contains(".")) return;
        _amount += v;
      }
    });
  }

  void _del() {
    if (_amount.isNotEmpty) {
      setState(() => _amount = _amount.substring(0, _amount.length - 1));
      if (_amount.isEmpty) _amount = "0";
    }
  }

  /*──────── confirmation flow ────────*/
  void _futa() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Confirmer le paiement'),
            content: Text('Envoyer $_amount FC ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Annuler'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentRed,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Confirmer'),
              ),
            ],
          ),
    );
    if (confirm == true) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Succès'),
              content: Text('Paiement envoyé avec succès ( $_amount FC )'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  /*──────── UI ────────*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryBlue),
        title: const Text(
          'Futa Mbongo',
          style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
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
        child: Center(
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Container(
              width: 340,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$_amount FC',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryBlue,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildPad(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: const BorderSide(color: kAccentRed, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Tika',
                            style: TextStyle(
                              color: kAccentRed,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kAccentRed,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: _futa,
                          child: const Text(
                            'Futa',
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
      ),
    );
  }

  Widget _buildPad() {
    final keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '0', 'X'];
    return SizedBox(
      width: 300,
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300, width: 1),
        children: [
          TableRow(children: keys.sublist(0, 3).map(_cell).toList()),
          TableRow(children: keys.sublist(3, 6).map(_cell).toList()),
          TableRow(children: keys.sublist(6, 9).map(_cell).toList()),
          TableRow(children: keys.sublist(9, 12).map(_cell).toList()),
        ],
      ),
    );
  }

  Widget _cell(String v) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(60, 60),
      ),
      onPressed: () {
        if (v == 'X')
          _del();
        else
          _append(v);
      },
      child: Text(
        v,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

import 'portal_page.dart';
import 'payment_history_page.dart';
import 'help_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> clientData;
  const HomePage({required this.clientData, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final List<Widget> _tabs = [
    PortalPage(clientData: widget.clientData),
    PaymentHistoryPage(clientData: widget.clientData),
    const HelpPage(),
    ProfilePage(clientData: widget.clientData),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'General'),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Paiements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Mituna',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

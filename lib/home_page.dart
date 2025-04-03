import 'package:flutter/material.dart';
import 'portal_page.dart';
import 'payment_history_page.dart';
import 'help_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    PortalPage(),
    PaymentHistoryPage(),
    HelpPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: "Futa",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Histoire"),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: "Lisungi",
          ),
        ],
      ),
    );
  }
}

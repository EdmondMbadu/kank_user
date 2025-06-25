// home_page.dart
import 'package:flutter/material.dart';

// ⬇️ Import only the widgets we need to avoid name clashes
import 'portal_page.dart' show PortalPage;
import 'payment_history_page.dart' show PaymentHistoryPage;
import 'help_page.dart' show HelpPage;
import 'profile_page.dart' show ProfilePage;

/*───────────────────────────────────────────────────────────*/
/*– Shared colour palette –*/
const Color kPrimaryBlue = Color(0xFF0A2A55); // deep navy-blue
const Color kLightGrey = Color(0xFF9E9E9E); // unselected icon
/*───────────────────────────────────────────────────────────*/

class HomePage extends StatefulWidget {
  final Map<String, dynamic> clientData;
  const HomePage({Key? key, required this.clientData}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    // Initialise tabs **after** the widget is ready
    _tabs = [
      PortalPage(clientData: widget.clientData),
      PaymentHistoryPage(clientData: widget.clientData),
      const HelpPage(),
      ProfilePage(clientData: widget.clientData),
    ];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: _currentIndex, children: _tabs),

    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kPrimaryBlue,
      unselectedItemColor: kLightGrey,
      onTap: (i) => setState(() => _currentIndex = i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'General'),
        BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payments'),
        BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: 'Help'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    ),
  );
}

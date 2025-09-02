



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samrat_chaudhary/presentation/publicFeedback/ui/public_feedback.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/ui/schemePolicies_screen.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/ui/goverments.dart';
import 'package:samrat_chaudhary/presentation/youth/ui/youthScreen.dart';

import '../core/utils/helper_functions.dart';
import 'Culture_Heritage/ui/Culture_heritage.dart';
import 'feedBack/ui/comlaintFeedbackScreen.dart';
import 'feedBack/ui/feedbackScreen.dart';
import 'publicEngagement_communication/ui/PublicEngagementScreens.dart';
import 'leadershipVision/ui/leaderShipVision.dart';

class BottomNavigationScreen extends StatefulWidget {
  final int index;
  const BottomNavigationScreen({super.key, required this.index});

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  late int _selectedIndex;

  final List<Widget> _screens = [
    PublicEngagementCommunicationScreen(),
    LeadershipVisionScreen(),
    //GovermentScreen(),
    //SchemePolicies(),
    CultureHeritage(),
   // PublicFeedback(),
    ComplaintFeedbackScreen(),
    PublicFeedback(),
  ];

  final List<String> _iconPaths = [
    'assets/icons/home.png',
    'assets/icons/index2.png',
   // 'assets/icons/index3.png',
  //  'assets/icons/index5.png',
    'assets/icons/tree.png',
   'assets/icons/index6.png',
    'assets/icons/index3.png',

  ];

  final List<String> lable = [
    'Home',
    'Leadership',
  //  'Schemes',
    'Culture',
  // 'Directory',
    'Complaint',
    "Contact"
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  void _onItemTapped(int index) {
    // if (index == 5) {
    //   // This is the link tab
    //   HelperFunctions.launchExternalUrl('https://pgportal.gov.in/');
    //   return;
    // }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        } else {

          SystemNavigator.pop();
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex > 4 ? 0 : _selectedIndex, // prevent out of bounds
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 12,
          selectedLabelStyle: TextStyle(fontSize: 12, color: Colors.orange),
          items: List.generate(5, (index) {
            return BottomNavigationBarItem(
              icon: Image.asset(
                _iconPaths[index],
                color: _selectedIndex == index ? Colors.orange : Colors.grey,
                width: 24,
                height: 24,
              ),
              label: lable[index],

            );
          }),
        ),
      ),
    );
  }
}

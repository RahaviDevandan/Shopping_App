import 'package:car_shopping_app/services/firebase_services.dart';
import 'package:car_shopping_app/tabs/home_tab.dart';
import 'package:car_shopping_app/tabs/saved_tab.dart';
import 'package:car_shopping_app/tabs/search_tab.dart';
import 'package:car_shopping_app/widgets/bottom_tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  late PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PageView(
            controller: _tabsPageController,
            onPageChanged: (num) {
              setState(() {
                _selectedTab = num;
              });
            },
            children: [
              HomeTab(),
              SearchTab(),
              SavedTab(),
            ],
          ),
        ),
        BottomTabs(
          selectedTab: _selectedTab,
          tabPressed: (num) {
            _tabsPageController.animateToPage(num,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOutCubic);
          },
        ),
      ],
    ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/models/app_tab.dart';
import 'package:login_firebase/theme.dart';


class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: theme.accentColor,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.web_asset), label:'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Watchlist'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Profile')
      ]
    );
  }
}
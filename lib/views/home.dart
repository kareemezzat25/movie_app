import 'package:flutter/material.dart';
import 'package:movies_app/views/tabs/browse_tab.dart';
import 'package:movies_app/views/tabs/home_tab.dart';
import 'package:movies_app/views/tabs/profile_tab.dart';
import 'package:movies_app/views/tabs/search_tab.dart';

class Home extends StatefulWidget {
  static const String routeName = "Home";

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  List<Widget> tabs = [HomeTab(), SearchTab(), BrowseTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/homeIcon.png")),
                label: ""),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/searchIcon.png")),
                label: ""),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/browseIcon.png")),
                label: ""),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/Profile.png")),
                label: "")
          ]),
    );
  }
}

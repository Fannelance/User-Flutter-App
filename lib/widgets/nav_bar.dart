import 'package:fannelance/extras/colors.dart';
import 'package:fannelance/models/custom_icons_icons.dart';
import 'package:fannelance/views/activity_view.dart';
import 'package:fannelance/views/home_view.dart';
import 'package:fannelance/views/services_view.dart';
import 'package:fannelance/views/user_view.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
  }) : super(key: key);

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  late List<Widget> _viewslist;

  @override
  void initState() {
    super.initState();
    _viewslist = <Widget>[
      HomeView(
        onLinkPressed: (int index) {
          _onItemTapped(index);
        },
      ),
      const ServicesView(),
      const ActivityView(),
      const UserView()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> navBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(CustomIcons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(CustomIcons.services),
      label: 'Services',
    ),
    BottomNavigationBarItem(
      icon: Icon(CustomIcons.activity),
      label: 'Activity',
    ),
    BottomNavigationBarItem(
      icon: Icon(CustomIcons.account),
      label: 'Account',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _viewslist.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 16,
          type: BottomNavigationBarType.fixed,
          iconSize: 25,
          unselectedFontSize: 15,
          selectedFontSize: 15,
          selectedItemColor: AppColors.black,
          unselectedItemColor: AppColors.gray7,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: navBarItems),
    );
  }
}

import 'package:fannelance/models/custom_icons_icons.dart';
// import 'package:fannelance/views/activity_view.dart';
import 'package:fannelance/views/home_view.dart';
import 'package:fannelance/views/services_view.dart';
// import 'package:fannelance/views/user_view.dart';
import 'package:flutter/material.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBarWidget> {
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
      // const ActivityView(),
      // const UserView(),
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
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _viewslist.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          type: BottomNavigationBarType.fixed,
          iconSize: screenWidth / 16,
          unselectedFontSize: screenWidth / 28,
          selectedFontSize: screenWidth / 28,
          selectedItemColor: const Color(0xff000000),
          unselectedItemColor: const Color(0xff777777),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: navBarItems),
    );
  }
}

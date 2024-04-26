import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/user/products/AllProduct.dart';
import 'package:flutter_application_1/page/user/Information/profile2.dart';
import 'package:flutter_application_1/page/user/products/wishlist.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _selectedIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  static const List<Widget> _widgetOptions = <Widget>[
    AllProduct(),
    Wishlist(),
    UserProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      backgroundColor: Colors.deepPurple,
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Theme.of(context).colorScheme.background,
        color: Theme.of(context).colorScheme.primary,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        animationDuration: const Duration(milliseconds: 300),
        items: [
          Icon(
            Icons.home,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Icon(
            Icons.favorite,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Icon(
            Icons.settings,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}

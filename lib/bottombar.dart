import 'package:flutter/material.dart';
import 'package:project1/place.dart';
import 'package:project1/maps.dart';

void main() {
  runApp(const BottomNav());
}

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottomNav',
      theme: ThemeData(),
      home: BottomNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  final screen = [
    MapsView(),
    PlaceList(),
  ];
  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.shifting;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff5b7ca8),
          unselectedItemColor: const Color(0xff757575),
          type: _bottomNavType,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems),
    );
  }
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.location_pin),
    activeIcon: Icon(Icons.location_pin),
    label: 'Maps',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.storefront),
    activeIcon: Icon(Icons.storefront),
    label: 'Places',
  ),

];
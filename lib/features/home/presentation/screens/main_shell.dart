import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Color(0xFFCBCBD4),
              weight: 1.5,
            ),
            activeIcon: Icon(
              Icons.home_outlined,
              color: Colors.black,
              weight: 1.5,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border_outlined,
              color: Color(0xFFCBCBD4),
              weight: 1.5,
            ),
            activeIcon: Icon(
              Icons.favorite_border_outlined,
              color: Colors.black,
              weight: 1.5,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xFFCBCBD4),
              weight: 1.5,
            ),
            activeIcon: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
              weight: 1.5,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

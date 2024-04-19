import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavigationBarWidget({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      fixedColor: Color.fromARGB(255, 80, 141, 221),
      items: const [
        
        BottomNavigationBarItem(
          label: "Calculator",
          icon: Icon(Icons.workspace_premium),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.account_circle),
        ),   
        
      ],
      onTap: onTap,
    );
  }
}

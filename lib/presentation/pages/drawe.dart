import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/presentation/pages/animation.dart';
import 'package:flutter_application_1/presentation/pages/course.dart';
import 'package:flutter_application_1/presentation/pages/profilepage.dart';
import 'package:flutter_application_1/presentation/pages/qrpage.dart';
import 'package:flutter_application_1/presentation/pages/stories.dart';

class My extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<My> {
  int _bottomNavIndex = 0;

  final iconList = <IconData>[
    Icons.home,
    Icons.qr_code,
    Icons.add_a_photo,
    Icons.animation_outlined,
  ];

  final screens = [
    ProfilePage(),
    QRCodePage(),
    Stories(),
    Animationn(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_bottomNavIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToNewPage(context, _bottomNavIndex),
        child: Icon(Icons.add, color: MYColors.secondaryColor),
        backgroundColor: MYColors.primaryColor, 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        backgroundColor: MYColors.primaryColor, 
        activeColor: MYColors.secondaryColor,
        inactiveColor: MYColors.secondaryColor, 
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }

  void navigateToNewPage(BuildContext context, int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CoursesScreen()));
  }
}
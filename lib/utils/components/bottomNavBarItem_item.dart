import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:movies/utils/constants.dart';

BubbleBottomBarItem bottomNavBarItem(IconData icon, String tag) {
  return BubbleBottomBarItem(
    backgroundColor: Colors.grey,
    icon: Icon(
      icon,
      color: Colors.grey,
    ),
    activeIcon: Icon(
      icon,
      color: SALMON,
    ),
    title: Text(
      tag,
      style: TextStyle(
        color: SALMON,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

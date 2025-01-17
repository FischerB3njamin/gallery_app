import 'package:flutter/material.dart';
import 'package:gallery_app/pages/about_me_page.dart';
import 'package:gallery_app/pages/gallery_page.dart';

abstract class Navigation {
  static const List<BottomNavigationBarItem> navigationItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.image),
      label: "Bilder",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Über mich",
    ),
  ];

  static const List<Widget> pages = [GalleryPage(), AboutMe()];
}

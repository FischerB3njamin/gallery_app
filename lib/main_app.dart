import 'package:flutter/material.dart';
import 'package:gallery_app/pages/gallery_page.dart';
import 'package:gallery_app/pages/about_me.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 89, 7, 36),
          title: Text(
            "Gallery",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: [GalleryPage(), AboutMe()][activeIndex],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 241, 234, 246),
            currentIndex: activeIndex,
            onTap: (value) => setState(() {
                  activeIndex = value;
                }),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.image),
                label: "Bilder",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Über mich",
              ),
            ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gallery_app/gallery_item_view.dart';
import 'package:gallery_app/pages/about_me.dart';
import 'package:gallery_app/data/gallery_data.dart';

void main() {
  runApp(const MainApp());
}

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
          backgroundColor: Color.fromARGB(255, 89, 7, 36),
          title: Text(
            "Gallery",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: [GalleryPager(), AboutMe()][activeIndex],
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

class GalleryPager extends StatelessWidget {
  const GalleryPager({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: EdgeInsets.all(8),
      children: [
        for (final item in galleryData)
          GestureDetector(
            onTap: () {
              Scaffold.of(context).showBottomSheet((BuildContext context) {
                return GalleryItemView(item: item);
              });
            },
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(item.imagePath, fit: BoxFit.fill),
                  ),
                  SizedBox(height: 8),
                  Center(child: Text(item.imageTitle)),
                  SizedBox(height: 8),
                ],
              ),
            ),
          )
      ],
    );
  }
}

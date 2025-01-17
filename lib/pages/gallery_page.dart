import 'package:flutter/material.dart';
import 'package:gallery_app/data/gallery_data.dart';
import 'package:gallery_app/data/gallery_item.dart';
import 'package:gallery_app/custom_widgets/gallery_card.dart';
import 'package:gallery_app/pages/gallery_new_item_page.dart';
import 'package:gallery_app/services/gallery_service.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<GalleryItem> gallery = galleryData;

  void handleFloatingActionButton() async {
    if (await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => GalleryNewItem()),
        ) ??
        false) {
      init();
    }
  }

  void init() {
    setState(() {
      gallery = GalleryService.gallery;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: EdgeInsets.all(8),
      children: [
        for (final item in gallery)
          GalleryCard(
            item: item,
            callback: init,
          ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: FloatingActionButton(
            elevation: 1,
            backgroundColor: Color.fromARGB(255, 89, 7, 36),
            onPressed: () => handleFloatingActionButton(),
            child: Icon(
              Icons.add_a_photo_outlined,
              color: Colors.white,
              size: 48,
            ),
          ),
        ),
      ],
    );
  }
}

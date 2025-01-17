import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_app/data/gallery_item.dart';
import 'package:gallery_app/pages/gallery_item_page.dart';
import 'package:gallery_app/services/gallery_service.dart';

class GalleryCard extends StatelessWidget {
  Function callback;
  GalleryCard({super.key, required this.item, required this.callback});

  final GalleryItem item;
  void handleTap(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GalleryItemView(
          index: GalleryService.gallery.indexOf(item),
        ),
      ),
    );
    callback();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleTap(context),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              child: item.custom
                  ? Image.file(
                      File(item.imagePath),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Image.asset(
                      item.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(child: Text(item.imageTitle)),
            ),
          ],
        ),
      ),
    );
  }
}

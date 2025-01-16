import 'package:flutter/material.dart';
import 'package:gallery_app/data/gallery_data.dart';
import 'package:gallery_app/pages/gallery_item_view.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

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
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        GalleryItemView(index: galleryData.indexOf(item))),
              );
            },
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
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
          )
      ],
    );
  }
}

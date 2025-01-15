import 'package:flutter/material.dart';
import 'package:gallery_app/data/gallery_item.dart';

class GalleryItemView extends StatelessWidget {
  GalleryItem item;
  GalleryItemView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 500),
          child: Image.asset(
            scale: 0.5,
            item.imagePath,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.imageTitle,
                style: TextStyle(fontSize: 24),
              ),
              Text(item.imageDate,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(item.imageDescription)
            ],
          ),
        )
      ],
    );
  }
}

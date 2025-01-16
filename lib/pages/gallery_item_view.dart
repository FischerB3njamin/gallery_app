import 'package:flutter/material.dart';
import 'package:gallery_app/data/gallery_data.dart';
import 'package:gallery_app/data/gallery_item.dart';

class GalleryItemView extends StatefulWidget {
  int index;
  GalleryItemView({super.key, required this.index});

  @override
  State<GalleryItemView> createState() => _GalleryItemViewState();
}

class _GalleryItemViewState extends State<GalleryItemView> {
  bool allowed = true;

  bool checkSwipeRight(int index, double direction) {
    return (direction < -8 && widget.index + 1 < galleryData.length);
  }

  bool checkSwipeLeft(int index, double direction) {
    return (direction > 8 && widget.index - 1 >= 0);
  }

  void handleSwipe(DragUpdateDetails details) {
    if (allowed) {
      allowed = false;
      widget.index += checkSwipeRight(widget.index, details.delta.dx) ? 1 : 0;
      widget.index -= checkSwipeLeft(widget.index, details.delta.dx) ? 1 : 0;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    GalleryItem item = galleryData[widget.index];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 89, 7, 36),
        title: Text(
          item.imageTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (_) => allowed = true,
        onHorizontalDragUpdate: (details) => handleSwipe(details),
        child: ListView(
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
        ),
      ),
    );
  }
}

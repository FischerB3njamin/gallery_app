import 'package:flutter/material.dart';
import 'package:gallery_app/data/gallery_item.dart';
import 'package:gallery_app/pages/gallery_new_item_page.dart';
import 'package:gallery_app/services/gallery_service.dart';

class GalleryItemView extends StatefulWidget {
  int index;
  GalleryItemView({super.key, required this.index});

  @override
  State<GalleryItemView> createState() => _GalleryItemViewState();
}

class _GalleryItemViewState extends State<GalleryItemView> {
  bool allowed = true;
  late List<GalleryItem> gallery;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() => setState(() => gallery = GalleryService.gallery);

  void showSnackbar(item) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${item.imageTitle} wurde gelöscht ")));

  bool checkSwipeRight(int index, double direction) =>
      (direction < -8 && widget.index + 1 < gallery.length);

  bool checkSwipeLeft(int index, double direction) =>
      (direction > 8 && widget.index - 1 >= 0);

  void handleSwipe(DragUpdateDetails details) {
    if (allowed) {
      allowed = false;
      widget.index += checkSwipeRight(widget.index, details.delta.dx) ? 1 : 0;
      widget.index -= checkSwipeLeft(widget.index, details.delta.dx) ? 1 : 0;

      setState(() {});
    }
  }

  void handleEdit(GalleryItem item) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GalleryNewItem(item: item, isNew: false),
      ),
    );
    init();
  }

  void handleDelete(GalleryItem item) {
    GalleryService.deleteItem(item);
    showSnackbar(item);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    GalleryItem item = gallery[widget.index];
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
        actions: [
          IconButton(onPressed: () => handleEdit(item), icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () => handleDelete(item), icon: Icon(Icons.delete)),
        ],
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

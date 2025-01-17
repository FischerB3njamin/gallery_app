import 'package:gallery_app/data/gallery_data.dart';
import 'package:gallery_app/data/gallery_item.dart';

class GalleryService {
  static List<GalleryItem> gallery = galleryData;

  static void addItem(GalleryItem item) => gallery.add(item);
  static void deleteItem(GalleryItem item) => gallery.remove(item);
  static void updateItem(GalleryItem oldItem, GalleryItem newItem) =>
      gallery[gallery.indexOf(oldItem)] = newItem;
}

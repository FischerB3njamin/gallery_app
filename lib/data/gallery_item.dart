class GalleryItem {
  String imageTitle;
  String imageDate;
  String imageDescription;
  String imagePath;
  bool custom;

  GalleryItem(
      {required this.imageDate,
      required this.imageDescription,
      required this.imagePath,
      required this.imageTitle,
      this.custom = false});
}

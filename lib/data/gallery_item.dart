class GalleryItem {
  String imageTitle;
  String imageDate;
  String imageDescription;
  String imagePath;
  String? imagesubHeadline;

  GalleryItem(
      {required this.imageDate,
      required this.imageDescription,
      required this.imagePath,
      required this.imageTitle,
      this.imagesubHeadline});
}

import 'dart:io';

import 'package:gallery_app/data/gallery_item.dart';
import 'package:gallery_app/custom_widgets/new_item_text_field.dart';
import 'package:gallery_app/services/gallery_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class GalleryNewItem extends StatefulWidget {
  const GalleryNewItem({super.key, this.item, this.isNew = true});
  final GalleryItem? item;
  final bool isNew;
  @override
  State<GalleryNewItem> createState() => _GalleryNewItemState();
}

class _GalleryNewItemState extends State<GalleryNewItem> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String uploadedImage = "";

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.item?.imageTitle ?? '';
    _dateController.text = widget.item?.imageDate ?? '';
    _descriptionController.text = widget.item?.imageDescription ?? '';
    uploadedImage = (widget.isNew
        ? ""
        : widget.item != null && widget.item!.custom
            ? widget.item!.imagePath
            : "");
  }

  void handleLoadImage() async {
    XFile? newMedia = await loadImage();
    if (newMedia != null) {
      setState(() => uploadedImage = newMedia.path);
    }
  }

  Future<XFile?> loadImage() async {
    final XFile? media = await ImagePicker().pickMedia();
    return media;
  }

  void handleSave() {
    widget.isNew ? handleNewItem() : handleUpdateItem();
    Navigator.pop(context, true);
  }

  void handleNewItem() {
    GalleryService.addItem(
      GalleryItem(
        imageDate: _dateController.text,
        imageDescription: _descriptionController.text,
        imagePath: uploadedImage,
        imageTitle: _titleController.text,
        custom: true,
      ),
    );
  }

  void handleUpdateItem() {
    GalleryItem newItem = widget.item!;
    newItem.imageDate = _dateController.text;
    newItem.imageDescription = _descriptionController.text;
    newItem.imageTitle = _titleController.text;

    if (uploadedImage.isNotEmpty) {
      newItem.imagePath = uploadedImage;
      newItem.custom = true;
    }
    GalleryService.updateItem(widget.item!, newItem);
  }

  Widget _buildImageDisplay() {
    return uploadedImage.isNotEmpty
        ? Image.file(File(uploadedImage), fit: BoxFit.cover)
        : (widget.item != null && widget.item!.imagePath.isNotEmpty
            ? Image.asset(widget.item!.imagePath, fit: BoxFit.cover)
            : SizedBox(
                height: 150,
                width: 300,
                child: Icon(Icons.add_a_photo, color: Colors.grey, size: 40)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color.fromARGB(255, 89, 7, 36),
          title: Text("Neuer eintrag",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            NewItemTextField(textController: _titleController, label: "Titel"),
            NewItemTextField(textController: _dateController, label: "Datum"),
            NewItemTextField(
                textController: _descriptionController, label: "Beschreibung"),
            GestureDetector(
              onTap: () => handleLoadImage(),
              child: _buildImageDisplay(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Abbrechen')),
                  Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Color.fromARGB(255, 89, 7, 36),
                      ),
                    ),
                    onPressed: () => handleSave(),
                    child: Text(
                      'Speichern',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

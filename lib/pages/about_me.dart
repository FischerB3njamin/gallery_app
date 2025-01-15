import 'package:flutter/material.dart';
import 'package:gallery_app/data/gallery_data.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Center(
          child: ClipOval(
            child: Image.asset(
              aboutMe.imagePath,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 16),
        Center(
            child: Text(
          aboutMe.imageTitle,
          style: TextStyle(fontSize: 24),
        )),
        Center(
          child: Text(
            aboutMe.imagesubHeadline ?? "",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 16),
        Text(aboutMe.imageDescription)
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:invoice_generator/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SetLogoScreen extends StatefulWidget {
  const SetLogoScreen({Key? key}) : super(key: key);

  @override
  State<SetLogoScreen> createState() => _SetLogoScreenState();
}

class _SetLogoScreenState extends State<SetLogoScreen> {
  XFile? pickedFile;
  File? newImage;
  String? path;

  getImageFromGallery() async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      maxWidth: 200,
    );
    if (pickedFile != null) {
      setState(() {
        newImage = File(pickedFile!.path);
      });
    }
  }

  // Widget imageFromGallery() {
  //   return FutureBuilder<File>(
  //     builder: (BuildContext context, AsyncSnapshot<File?> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         if (snapshot.data == null) {
  //           return const Text("Error loading file");
  //         }
  //       }
  //         return Image.file(imageFile!);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Set Logo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          children: [
            Center(
              child: newImage == null
                  ? Image.asset(
                      'assets/images/logo.png',
                      width: 200,
                      height: 200,
                    )
                  : Image.file(
                      newImage!,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () => getImageFromGallery(),
              child: const Text(
                'Set New Logo',
                style: TextStyle(
                  color: kwhite,
                ),
              ),
              color: kred,
            ),
            MaterialButton(
              onPressed: () {},
              child: const Text(
                'Remove Logo',
                style: TextStyle(
                  color: kwhite,
                ),
              ),
              color: kred,
            ),
          ],
        ),
      ),
    );
  }
}

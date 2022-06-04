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
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() {
        newImage = File(pickedFile!.path);
      });
      showInSnackBar(context, 'New logo has been set.');
    } else {
      showInSnackBar(context, 'Error loading image. Try again.');
    }
  }

  void showInSnackBar(context, String value) {
    final snackBar = SnackBar(
      content: Text(value),
      backgroundColor: kred,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'DISMISS',
        textColor: kwhite,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Recommended Image \nSpecifications',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Text(
              '200x200 PNG or 1:1 ratio image',
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                getImageFromGallery();
              },
              child: const Text(
                'Set New Logo',
                style: TextStyle(
                  color: kwhite,
                ),
              ),
              color: kred,
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  newImage = null;
                });
                showInSnackBar(context, 'Logo has been cleared.');
              },
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

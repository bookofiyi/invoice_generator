import 'package:flutter/material.dart';
import 'package:invoice_generator/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_generator/form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SetLogoScreen extends StatefulWidget {
  const SetLogoScreen({Key? key}) : super(key: key);

  @override
  State<SetLogoScreen> createState() => _SetLogoScreenState();
}

class _SetLogoScreenState extends State<SetLogoScreen> {
  XFile? pickedFile;
  String? pickedFilePath;
  File? newImage;

  getImageFromGallery() async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      maxWidth: 200,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() {
        pickedFilePath = pickedFile!.path;
        newImage = File(pickedFilePath!);
        setPathAndState(pickedFilePath!);
      });
      showInSnackBar(this.context, 'New logo has been set.');
    } else {
      showInSnackBar(this.context, 'Error loading image. Try again.');
    }
  }

  // stores the path of the image to persistent storage
  setPathAndState(String pickedFilePath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(pickedFilePath);
    // final savedImage = await newImage!.copy('${appDir.path}/$fileName');
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', '${appDir.path}/$fileName');
    prefs.setBool('imagePathSet', true);
  }

  // clears the path of the image from persistent storage
  clearPathAndState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', '');
    prefs.setBool('imagePathSet', false);
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
          ScaffoldMessenger.of(this.context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
  }

  // on creation of the set_logo screen, checks if a logo is already
  // set. If set, this sets the path of the pickedImage to the path
  // of the image in local storage, thus displaying the set image.
  // Otherwise, displays a placeholder image.
  @override
  void initState() {
    checkIfPathSet();
    super.initState();
  }

  checkIfPathSet() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePathSet = prefs.getBool('imagePathSet') ?? false;
    if (imagePathSet == true) {
      pickedFilePath = prefs.getString('imagePath');
      setState(() {
        newImage = File(pickedFilePath!);
      });
    }
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
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Center(
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
                      clearPathAndState();
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
          Center(
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FormScreen()));
              },
              minWidth: double.infinity,
              height: 70,
              elevation: 3,
              color: kred,
              child: const Text(
                'Back to Home',
                style: TextStyle(
                  fontSize: 25,
                  color: kwhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

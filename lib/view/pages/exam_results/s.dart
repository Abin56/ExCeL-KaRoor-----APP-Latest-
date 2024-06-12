import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
 late File _image;
  double _uploadProgress = 0.0;

  Future<void> _uploadImage() async {
    // ignore: unnecessary_null_comparison
    if (_image == null) {
      return;
    }

    final storage = FirebaseStorage.instance;
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageRef = storage.ref().child('images/$fileName');

    final UploadTask uploadTask = storageRef.putFile(
      _image,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      setState(() {
        _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
      });
    }, onError: (Object e) {
      print(e.toString());
    });

    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();

    print('Download URL: $downloadUrl');
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: unnecessary_null_comparison
            if (_image != null)
              Image.file(
                _image,
                height: 200,
              ),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: const Text('Choose Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(value: _uploadProgress),
            Text('${(_uploadProgress * 100).toStringAsFixed(2)}%'),
          ],
        ),
      ),
    );
  }
}

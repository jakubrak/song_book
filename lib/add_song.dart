import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class AddSongPage extends StatefulWidget {
  const AddSongPage({super.key});

  @override
  State<AddSongPage> createState() => _AddSongPageState();
}

class _AddSongPageState extends State<AddSongPage> {
  Future<void> _dialogBuilder(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Camera error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add song')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final ImagePicker picker = ImagePicker();
            final heicImage = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
            if (heicImage == null) return;
            // final imageData = await File(heicImage.path).readAsBytes();
            // print(imageData.length);
            // final image = img.decodeImage(imageData);
            // final jpegImage = img.JpegEncoder().encode(image!);
            // print(jpegImage.length);
            // final file = await File(heicImage.path).copy('${heicImage.path}.jpeg');
            // await file.writeAsBytes(jpegImage);
            final ref = FirebaseStorage.instance.ref().child("test.jpeg");
            await ref.putFile(File(heicImage.path));

            final result = await FirebaseFunctions.instance.httpsCallable('annotateImage').call({
              "image": {"content": base64Encode(await heicImage.readAsBytes())},
              "features": [ {"type": "TEXT_DETECTION"} ]
            });
            print(result.data.toString());
          } on FirebaseFunctionsException catch (e) {
            print(e.code);
            print(e.details);
            print(e.message);
          } on PlatformException catch(e) {
            print('Failed to pick image: $e');
          }
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.photo_camera),
      ),
    );
  }
}
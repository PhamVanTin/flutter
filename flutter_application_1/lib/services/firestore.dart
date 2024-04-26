import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
//import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('Products');
  //Create
  Future<void> addProducts(String name, String des, String price) {
    return products.add({
      'name': name,
      'des': des,
      'price': price,
      'timestamp': Timestamp.now(),
    });
  }

  Future<File?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}

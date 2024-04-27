import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/category.dart';

class CategoryController {
  Future<List<Category>> getProducts() async {
    await Firebase.initializeApp();
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    List<Category> categories = snapshot.docs.map((doc) {
      return Category.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    return categories;
  }

  Future<void> addCategory(Category category) async {
    await FirebaseFirestore.instance
        .collection('category')
        .doc(category.id)
        .set(category.toMap());
  }

  Future<void> deleteCategory(String categoryId) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(categoryId)
        .delete();
  }
}

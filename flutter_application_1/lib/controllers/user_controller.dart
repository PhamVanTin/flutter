import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_application_1/model/user_model.dart';

class UserController {
  Future<Users?> getUserById(String documentId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(documentId)
              .get();

      if (documentSnapshot.exists) {
        Users user = Users.fromMap(documentSnapshot.data()!);
        return user;
      }
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  Future<void> addUser(Users Users) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(Users.email)
        .set(Users.toMap());
  }

  Future<void> updateUser(
      String email, Map<String, dynamic> dataToUpdate) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .update(dataToUpdate);
  }

  Future<void> wishlist(Users Users, Product product) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(Users.email)
        .collection('wishlist')
        .doc(product.id);
  }
}
